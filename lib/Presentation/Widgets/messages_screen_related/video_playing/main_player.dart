import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../video_player.dart';

class MyVideoMessage extends HookWidget {
  const MyVideoMessage({
    super.key,
    required this.mq,
    required this.videoMessage,
  });

  final Size mq;
  final VideoMessage videoMessage;
  @override
  Widget build(BuildContext context) {
    final offlinePath = videoMessage.metadata!['offlinePath']!;
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
          if (videoMessage.metadata!['type'] == 'offline' &&
              videoMessage.author.id !=
                  FirebaseAuth.instance.currentUser!.uid) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (videoMessage.metadata!['type'] == 'offline') {
            return MyOfflineVideoPlayerThumbnail(videoMessage: videoMessage);
          }
          if (fileExists.hasData && fileExists.data!) {
            return MyOfflineVideoPlayerThumbnail(
              videoMessage: videoMessage,
              savedOnline: true,
            );
          }
          if (!fileExists.hasData ||
              (fileExists.hasData && !fileExists.data!)) {
            return MyOnlineVideoPlayerThumbnail(videoMessage: videoMessage);
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
