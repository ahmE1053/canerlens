import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../Presentation/Widgets/authentication_handling_widgets/error_dialog.dart';
import 'auth_provider.dart';

/*
* this is a kinda of big class because it handles all the details of creating the account
* the main class which is gonna be the state of the notifier has all its values nullable
* because it waits for the related function to add the info the user entered
* */
class CreateAccountInfo {
  final String? name, imageUrl;
  final File? image;
  final DateTime? dateOfBirth;
  final double startProgress, endProgress;
  final bool drive;

  const CreateAccountInfo({
    this.image,
    this.dateOfBirth,
    this.name,
    this.imageUrl,
    this.startProgress = 0.0,
    this.endProgress = 0.0,
    this.drive = false,
  });

  CreateAccountInfo copyWith(
      {String? name,
      String? imageUrl,
      File? image,
      DateTime? dateOfBirth,
      double? startProgress,
      double? endProgress,
      bool? drive}) {
    return CreateAccountInfo(
      image: image ?? this.image,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      startProgress: startProgress ?? this.startProgress,
      endProgress: endProgress ?? this.endProgress,
      drive: drive ?? this.drive,
    );
  }

  @override
  String toString() => '$name $dateOfBirth $imageUrl ';
}

/*
* this notifier is auto disposed because it is not required again after the creation of the account
* it holds the state of the CreateAccountInfo and modifies it as the user enter the details
* */

class CreateAccountInfoNotifier extends AutoDisposeNotifier<CreateAccountInfo> {
  /*
  * those two variable handle the animation of the progress bar (or circle in this case)
  * one for starting the small animation that relates to uploading a small chunk of the file
  * and the other marks the success of the uploading process
  * */

  //TODO: handle if the connection was interrupted

  bool drive = false;
  bool done = false;

  @override
  CreateAccountInfo build() {
    return const CreateAccountInfo();
  }

  ///this is kinda copyWith but to write less code in the widget that uses it
  void editInfo({String? name, String? imageUrl, DateTime? dateOfBirth}) {
    state = state.copyWith(
      name: name,
      imageUrl: imageUrl,
      dateOfBirth: dateOfBirth,
    );
  }

  ///This handles the selection of the image and copying it to the app storage
  ///making it ready for the upload process
  Future<void> selectImage(BuildContext context) async {
    ImageSource? imageSource;
    //shows a dialog to choose the source of the image
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(top: 10, bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'Pick a source',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Camera'),
                onTap: () {
                  imageSource = ImageSource.camera;
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () {
                  imageSource = ImageSource.gallery;
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
    if (imageSource == null) {
      return;
    }
    final imagePicker = ImagePicker();
    final xImage =
        (await imagePicker.pickImage(source: imageSource!, imageQuality: 30));
    if (xImage == null) return;
    final appPath = (await getApplicationDocumentsDirectory()).path;
    final imagePath = '$appPath/${basename(xImage.path)}';
    await xImage.saveTo(imagePath);
    final File image = File(imagePath);
    state = state.copyWith(image: image);
  }

  /*
  * handles the uploading logic
  * it takes the image file that was put in the state, creates a ref for it in storage
  * and uploads it to this reference
  * */

  Future<void> uploadImage() async {
    final imageRef = FirebaseStorage.instance.ref(basename(state.image!.path));
    /*
    * this function is related to the progress bar animation
    * it uses to state startProgress and endProgress to make the animation go from
    * the start to the end and marks drive to true to start the animation
    * then when the animation is done it marks drive as false and waits for it to be true again
    * to move to the next endProgress until it ends
    * and because i can't figure out how to make the function wait the stream to end before proceeding
    * i made a loop that doesn't end until the stream ends
    * then the url is copied to the state
    */

    imageRef.putFile(state.image!).snapshotEvents.listen(
      (event) {
        drive = true;
        final transferred = event.bytesTransferred;
        final total = event.totalBytes;
        if (event.state == TaskState.success) done = true;
        state = state.copyWith(
          startProgress: state.endProgress == 1.0
              ? state.startProgress
              : state.endProgress,
          endProgress: total == -1 ? 0.0 : (transferred / total),
          drive: true,
        );
      },
    );
    while (state.endProgress != 1.0) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    var downloadUrl = await imageRef.getDownloadURL();
    state = state.copyWith(imageUrl: downloadUrl);
  }

  /*
  * this is the big boy of this notifier
  * it handles all the details and calls all the related functions to the creation process
  * it returns a number because if it failed it resets the loading animation
  */

  Future<int> createAccount({
    required ValueNotifier<List<int?>> dateOfBirth,
    required ValueNotifier<List<bool>> dateOfBirthErrorStateList,
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    /*
    * first it checks whether the user didn't put his date of birth correctly
    * if so it marks the error state of that related button as true and the button will
    * become red indicating it needs to be chosen and stops the function
    * */

    //Error Handling
    final dOB = dateOfBirth.value;
    dateOfBirthErrorStateList.value = [
      dOB[0] == null,
      dOB[1] == null,
      dOB[2] == null
    ];
    bool dateOfBirthErrorState = false;
    for (bool state in dateOfBirthErrorStateList.value) {
      dateOfBirthErrorState = state;
    }
    if (!formKey.currentState!.validate() || dateOfBirthErrorState) {
      return 1;
    }
    /*
    * this is related to the skipping of uploading an image
    * it shows an alert to tell the user he didn't select an image
    * if the user selected continue then the functinon will proceed
    */
    final imageStatus = state.image == null;

    //skipping image alert
    bool skipImage = true;
    if (imageStatus) {
      skipImage = false;
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          title: const Text(
            'Are you sure about not selecting a profile picture',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                skipImage = true;
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        ),
      );
    }
    final authProvider = authenticationProvider.notifier;
    if (!skipImage) {
      return 1;
    }
    if (!imageStatus) {
      await uploadImage();
    }
    /*
    * this create add the name and date of birth to the state making it finally ready for creating the account
    * and it also makes the date of birth in a suitable format of DateTime.parse()
    * */

    editInfo(
      name: name,
      dateOfBirth: DateTime.parse(
          '${dOB[0]}-${dOB[1]! < 10 ? '0' : ''}${dOB[1]}-${dOB[2]! < 10 ? '0' : ''}${dOB[2]}'),
    );

    //creates the account
    await ref.read(authProvider).createAccount(
          email,
          password,
        );
    //if an error occurred it stops the function and shows an error dialog

    if (ref.read(authProvider).errorState && context.mounted) {
      await errorDialog(
        ref.read(authProvider).errorText,
        context,
      );
      return 1;
    }
    //if not it configures the account by adding it to firestore
    await ref.read(authProvider).configureAccount();
    //goes to the home screens
    if (context.mounted) context.router.replaceNamed('/home');
    return 0;
  }

  //this is used by the animation to mark that is done and waits for the next start
  void stop() {
    drive = false;
  }
}

final createAccountInfoProvider =
    NotifierProvider.autoDispose<CreateAccountInfoNotifier, CreateAccountInfo>(
  () => CreateAccountInfoNotifier(),
);
