import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../generated/locale_keys.g.dart';
import 'show_snack_bar.dart';

Future<XFile?> imagePicker(BuildContext context) async {
  ImageSource? imageSource;
  await showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(
              Icons.camera,
            ),
            title: Text(LocaleKeys.camera.tr()),
            onTap: () {
              imageSource = ImageSource.camera;
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.image,
            ),
            title: Text(LocaleKeys.gallery.tr()),
            onTap: () {
              imageSource = ImageSource.gallery;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
  if (imageSource == null) {
    if (context.mounted) {
      showSnackBar(context, LocaleKeys.selectAnImageSource.tr());
    }
    return null;
  }
  final xfile = await ImagePicker().pickImage(
    source: imageSource!,
    imageQuality: 60,
  );
  Widget alert(_) {
    return AlertDialog(
      title: Text(
        LocaleKeys.noImgSelected.tr(),
      ),
      alignment: AlignmentDirectional.center,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text(
            LocaleKeys.ok.tr(),
          ),
        )
      ],
    );
  }

  return xfile;
}

Future<Map<String, Object>?> imagePickerForChatScreen(
    BuildContext context, String messageId) async {
  final colorScheme = Theme.of(context).colorScheme;
  bool video = false;
  ImageSource? imageSource;
  await showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.image.tr()),
          Divider(
            thickness: 2,
            color: colorScheme.primaryContainer,
          ),
          ListTile(
            leading: const Icon(
              Icons.camera,
            ),
            title: Text(LocaleKeys.camera.tr()),
            onTap: () {
              imageSource = ImageSource.camera;
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.image,
            ),
            title: Text(LocaleKeys.gallery.tr()),
            onTap: () {
              imageSource = ImageSource.gallery;
              Navigator.pop(context);
            },
          ),
          Text(LocaleKeys.video.tr()),
          Divider(
            thickness: 2,
            color: colorScheme.primaryContainer,
          ),
          ListTile(
            leading: const Icon(
              Icons.camera,
            ),
            title: Text(LocaleKeys.camera.tr()),
            onTap: () {
              video = true;
              imageSource = ImageSource.camera;
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.image,
            ),
            title: Text(LocaleKeys.gallery.tr()),
            onTap: () {
              video = true;
              imageSource = ImageSource.gallery;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
  if (imageSource == null) {
    if (context.mounted) {
      showSnackBar(context, LocaleKeys.selectAnImageSource.tr());
    }
    return null;
  }
  final xfile = video
      ? await ImagePicker().pickVideo(
          source: imageSource!,
        )
      : await ImagePicker().pickImage(
          source: imageSource!,
          imageQuality: 10,
        );
  if (xfile == null) {
    if (context.mounted) {
      showSnackBar(
        context,
        LocaleKeys.noImgSelected.tr(),
      );
    }
    return null;
  }
  final phonePath = await getApplicationDocumentsDirectory();
  final fullFilePath =
      path.join(phonePath.path, '$messageId${path.extension(xfile.name)}');
  await xfile.saveTo(fullFilePath);
  return {
    'path': fullFilePath,
    'video': video,
  };
}
