import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/providers/lung_percentage_provider.dart';
import '../../core/providers/skin_percentage_provider.dart';
import '../../core/utilities/check_image_first.dart';
import '../../core/utilities/image_picker.dart';
import '../../core/utilities/run_lung_model.dart';
import '../../core/utilities/run_skin_model.dart';
import '../../core/utilities/wrong_image_text_generator.dart';
import '../../domain/entities/two_images.dart';

class MyImageProvider extends Notifier<TwoImagesClass> {
  @override
  TwoImagesClass build() {
    return const TwoImagesClass();
  }

  Future<void> runOnSkinImage(
      BuildContext context, ValueNotifier<bool> loading) async {
    if (state.skinImg == null) return;
    final percentage = await runSkinModel(state.skinImg!.path);
    ref.read(skinPercentageProvider.notifier).update((state) => percentage);
    return;
  }

  Future<void> runOnLungImage(
      BuildContext context, ValueNotifier<bool> loading) async {
    if (state.lungImg == null) return;
    final percentage = await runLungModel(state.lungImg!.path);
    ref.read(lungPercentageProvider.notifier).update((state) => percentage);
    return;
  }

  Future<void> addLungImgPath(BuildContext context) async {
    final img = await imagePicker(context);
    if (img == null) {
      return;
    }
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: img.path,
      uiSettings: [
        AndroidUiSettings(lockAspectRatio: false),
      ],
    );
    if (croppedImage == null) {
      return;
    }
    final pathToSave = await getApplicationDocumentsDirectory();
    final ext = extension(croppedImage.path);
    final lungImgPath =
        '${pathToSave.path}/${DateTime.now().toIso8601String()}$ext';
    await File(croppedImage.path).copy(lungImgPath);
    state = TwoImagesClass(
      lungImg: File(lungImgPath),
      skinImg: state.skinImg,
    );
  }

  Future<void> addSkinImgPath(BuildContext context) async {
    final img = await imagePicker(context);
    if (img == null) {
      return;
    }
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: img.path,
      uiSettings: [
        AndroidUiSettings(lockAspectRatio: false),
      ],
    );
    if (croppedImage == null) {
      return;
    }
    final pathToSave = await getApplicationDocumentsDirectory();
    final ext = extension(croppedImage.path);
    final skinImgPath =
        '${pathToSave.path}/${DateTime.now().toIso8601String()}$ext';
    await File(croppedImage.path).copy(skinImgPath);
    state = TwoImagesClass(
      skinImg: File(skinImgPath),
      lungImg: state.lungImg,
    );
  }
}

final imgProvider =
    NotifierProvider<MyImageProvider, TwoImagesClass>(() => MyImageProvider());
