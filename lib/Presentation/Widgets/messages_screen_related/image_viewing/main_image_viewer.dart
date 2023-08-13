import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import 'offline_image_viewer.dart';
import 'online_image_viewer.dart';

class MyImageMessage extends HookWidget {
  const MyImageMessage({
    super.key,
    required this.mq,
    required this.imageMessage,
  });

  final Size mq;
  final ImageMessage imageMessage;
  @override
  Widget build(BuildContext context) {
    final offlinePath = imageMessage.metadata!['offlinePath']!;
    final fileExists =
        useFuture(useMemoized(() => File(offlinePath).exists(), [offlinePath]));
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: mq.height * 0.3,
        minHeight: mq.height * 0.15,
        maxWidth: mq.width * 0.5,
        minWidth: mq.width * 0.4,
      ),
      child: Builder(
        builder: (context) {
          if (imageMessage.metadata!['type'] == 'offline') {
            return MyOfflineImageMessage(imageMessage: imageMessage);
          }
          if (fileExists.hasData && fileExists.data!) {
            return MyOfflineImageMessage(
              imageMessage: imageMessage,
              savedOnline: true,
            );
          }
          if (fileExists.hasData && !fileExists.data!) {
            return MyOnlineImageMessage(imageMessage: imageMessage);
          }
          return Center(
            child: SpinKitChasingDots(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          );
        },
      ),
    );
  }
}
