import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/painters/circle_painter.dart';
import '../../../core/providers/create_account_provider.dart';

class ImageSelectionWidget extends HookConsumerWidget {
  const ImageSelectionWidget({Key? key}) : super(key: key);
/*
* this holds the image of the user
* it shows a grey person when no image is selected
* and shows a the selected image when selected then shows a progress circle around it when uploading and
* finally a green circle when done
* */

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mq = MediaQuery.of(context).size;
    final accountInfo = ref.watch(createAccountInfoProvider);
    final accountInfoNotifier = ref.read(createAccountInfoProvider.notifier);
    final successController =
        useAnimationController(duration: const Duration(milliseconds: 1000));
    final strokeWidthTween =
        Tween<double>(begin: 5, end: 0).animate(successController);

    final successTween = TweenSequence(
      [
        TweenSequenceItem(
            tween: Tween<double>(begin: 0.0, end: 1.0), weight: 50),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 1.2), weight: 10),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.2, end: 1.0), weight: 10),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 1.1), weight: 10),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.1, end: 1.0), weight: 10),
      ],
    ).animate(successController);

    final loadingController =
        useAnimationController(duration: const Duration(milliseconds: 400));

    final loadingTween = Tween<double>(
      begin: accountInfo.startProgress * 2,
      end: accountInfo.endProgress * 2 + .01,
    ).animate(loadingController);

    if (accountInfoNotifier.drive) {
      if (loadingController.isCompleted) {
        loadingController.reset();
      }
      loadingController.forward();
      accountInfoNotifier.stop();
    }
    if (accountInfoNotifier.done) {
      successController.forward();
    }

    return SizedBox(
      width: max(mq.width * 0.25, mq.width * 0.25 * successTween.value),
      height: max(mq.width * 0.25, mq.width * 0.25 * successTween.value),
      child: GestureDetector(
        onTap: () {
          ref.read(createAccountInfoProvider.notifier).selectImage(context);
        },
        child: AnimatedBuilder(
          animation: Listenable.merge([
            loadingTween,
            successTween,
          ]),
          builder: (context, child) {
            return CustomPaint(
              painter: CirclePainter(
                loadingTween.value,
                successTween.value,
                strokeWidthTween.value,
              ),
              child: Padding(
                padding: EdgeInsets.all(min(loadingTween.value, 1) * 5),
                child: ClipOval(
                  child: Image.file(
                    accountInfo.image ?? File(''),
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) => SizedBox(
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Container(
                            color: Colors.grey,
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: FittedBox(
                                child: Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            height: mq.width * 0.25 * .3,
                            width: mq.width * 0.25,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
