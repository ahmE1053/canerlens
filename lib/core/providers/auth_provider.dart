import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:medapp4/core/providers/language_provider.dart';
import 'package:medapp4/core/utilities/context_extensions.dart';
import 'package:medapp4/generated/locale_keys.g.dart';
import 'package:uuid/uuid.dart';

import 'create_account_provider.dart';

/*
* this class is used to hold the authentication state of the app
* it holds a state of firebase auth user which checks at the start of the app
* if there is a currently logged in user or not
* and therefore influences the start of the application to go the auth screen
* if there is no user or if there is a user uses his login to get his info from
* firestore and show them in the app
* it also holds an error state and an error text in case of an error
* this is mostly gonna be wrong auth details related because
* in case of network not working the buttons will be disabled
* */

class AuthenticationNotifier extends Notifier<User?> {
  final firebaseAuth = FirebaseAuth.instance;
  bool errorState = false;
  String errorText = '';

  @override
  User? build() {
    final user = firebaseAuth.currentUser;
    return user;
  }

  ///Used to sign the user out and then change the state of the notifier
  ///to be null

  void signOut(BuildContext context) {
    context.router.replaceNamed('/auth');
    firebaseAuth.signOut();
    ref.invalidateSelf();
  }

  //TODO: add phone auth
  ///Used to sign in user by using email and password
  /*
  * It changes the error state to false in case there were a previous wrong attempt
  * and tries to sign in with the given details
  * if correct the state will change and the app will go to the main screen
  * if not the error state will change causing a dialog to appear with the error details
  */

  Future<void> signIn(String email, String password) async {
    errorState = false;
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      ref.invalidateSelf();
    } on FirebaseAuthException catch (e) {
      errorState = true;
      if (e.code == 'wrong-password') {
        errorText = 'You have entered an incorrect password. Please try again';
      } else if (e.code == 'user-not-found') {
        errorText = 'There is no user with this email';
      } else if (e.code == 'user-not-found') {
        errorText = 'There is no user registered with this email';
      } else if (e.code == 'network-request-failed' ||
          e.code == 'internal-error' ||
          e.code == 'invalid-auth-event' ||
          e.code == 'missing-iframe-start') {
        errorText = 'Something went wrong. Please try again later';
      }
    }
  }

  ///Used to create a new account for the user
  /*
  * it it creates an account as before but in this case the app will not call this function directly to create an
  * account it will call a function of the create account notifier to handle all the details of the user
  * and add them to firestore after the account is created which is not possible in here
  * and adding those details here will collide with the point of this notifier which is to handle auth details only
  */

  Future<void> createAccount(String email, String password) async {
    errorState = false;
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      ref.invalidateSelf();
    } on FirebaseAuthException catch (e) {
      errorState = true;
      if (e.code == 'email-already-in-use') {
        errorText = 'The provided email is already in use by an existing user.';
      } else if (e.code == 'network-request-failed' ||
          e.code == 'internal-error' ||
          e.code == 'invalid-auth-event' ||
          e.code == 'missing-iframe-start') {
        errorText = 'Something went wrong. Please try again later';
      }
    }
  }

  /*
  * it adds the account's info to firestore but the same thing as before it is not called directly
  * but called in the create account notifier function
  * it reads the details of this notifier and adds them to firestore in a doc named after the userid generated by
  * firebase auth
  * */

  Future<void> configureAccount() async {
    //null operator is used because this will not be called until the user is signed in
    final user = state!;
    final accountInfo = ref.read(createAccountInfoProvider);
    //the user can skip uploading an image
    await user.updatePhotoURL(accountInfo.imageUrl ?? '');
    await user.updateDisplayName(accountInfo.name!);

    //all those additional fields are because the from json takes those
    //so they can't be null
    await FirebaseFirestore.instance.collection('patients').doc(user.uid).set(
      {
        'id': user.uid,
        'email': user.email,
        'appointments': [],
        'joinedOn': DateTime.now().toIso8601String(),
        'chatList': [],
        'name': accountInfo.name!,
        'imageUrl': accountInfo.imageUrl ?? '',
        'dateOfBirth': accountInfo.dateOfBirth!.toIso8601String(),
        'favoriteDoctors': [],
      },
    );
    ref.invalidateSelf();
  }

  /*
  * this is to add list tiles in the profile screen
  * if the didn't verify his email then it show a verify email tile, etc.
  */
  List<Map<String, dynamic>> addToListTiles(BuildContext context) {
    final listOfSetting = [
      context.isArabic
          ? {
              'title': 'تغيير اللغة',
              'subtitle': 'تغيير إلى اللغة الانجليزية',
              'onTap': () {
                context.setToEnglish();
                ref
                    .read(languageProvider.notifier)
                    .update((state) => const Uuid().v4());
              },
            }
          : {
              'title': 'Change Language',
              'subtitle': 'Change to Arabic',
              'onTap': () {
                context.setToArabic();
                ref
                    .read(languageProvider.notifier)
                    .update((state) => const Uuid().v4());
              },
            },
    ];
    if (!state!.emailVerified) {
      listOfSetting.add(
        {
          'title': LocaleKeys.verifyEmail.tr(),
          'subtitle': LocaleKeys.emailNotVerified.tr(),
          'textColor': Colors.red,
          'onTap': () {},
        },
      );
    }
    // if (state!.phoneNumber == '' || state!.phoneNumber == null) {
    //   listOfSetting.add(
    //     {
    //       LocaleKeys.addNumber.tr(),
    //       LocaleKeys.addNumberDesc.tr(),
    //       'title': 'Add a phone number',
    //       'subtitle': 'For easier logging in and restoration of your account',
    //       'onTap': () {},
    //     },
    //   );
    // }
    return listOfSetting;
  }
}

final authenticationProvider = NotifierProvider<AuthenticationNotifier, User?>(
  () => AuthenticationNotifier(),
);
