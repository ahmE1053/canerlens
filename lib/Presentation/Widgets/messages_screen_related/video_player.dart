import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/providers/navigation_bar_provider.dart';
import '../../../core/utilities/generate_video_thumbnail.dart';

class MyOfflineVideoPlayerThumbnail extends HookConsumerWidget {
  const MyOfflineVideoPlayerThumbnail(
      {Key? key, required this.videoMessage, this.savedOnline = false})
      : super(key: key);
  final types.VideoMessage videoMessage;
  final bool savedOnline;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final mq = MediaQuery.of(context).size;
    final loading = useState(false);
    final videoThumbnail = useFuture(
      useMemoized(() => generateThumbnail(videoMessage.uri)),
    );
    return SizedBox(
      height: mq.height * 0.3,
      width: mq.width * 0.5,
      child: Builder(
        builder: (context) {
          if (!(videoThumbnail.connectionState == ConnectionState.done)) {
            return const Center(
              child: SpinKitChasingDots(
                color: Colors.red,
              ),
            );
          }
          return Hero(
            tag: 'video${videoMessage.id}',
            child: GestureDetector(
              onTap: () async {
                final videoPlayerController = VideoPlayerController.file(
                  File(
                    savedOnline
                        ? videoMessage.metadata!['offlinePath']
                        : videoMessage.uri,
                  ),
                );

                loading.value = true;
                await videoPlayerController.initialize();
                final chewieController = ChewieController(
                  videoPlayerController: videoPlayerController,
                  allowFullScreen: true,
                  allowedScreenSleep: false,
                  allowMuting: true,
                  allowPlaybackSpeedChanging: false,
                  autoPlay: true,

                  showOptions: false,
                  materialProgressColors: ChewieProgressColors(
                    backgroundColor: Colors.white,
                    bufferedColor: Colors.grey.withOpacity(0.7),
                    handleColor: colorScheme.primary,
                    playedColor: colorScheme.primaryContainer,
                  ),
                  // cupertinoProgressColors: ChewieProgressColors()
                  looping: false,
                  zoomAndPan: false,
                );
                loading.value = false;

                ref.read(navigationBarProvider.notifier).update((state) => 0.0);
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MyVideoPlayerScreen(
                          videoMessage: videoMessage,
                          videoPlayerController: videoPlayerController,
                          chewieController: chewieController,
                        );
                      },
                    ),
                  );
                }
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.memory(
                    videoThumbnail.data!,
                    fit: BoxFit.fill,
                  ),
                  Positioned.fill(
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: Builder(
                          builder: (context) {
                            if (loading.value) {
                              return const SpinKitChasingDots(
                                color: Colors.white,
                              );
                            }
                            return const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Builder(
                        builder: (context) {
                          final progress =
                              videoMessage.metadata!['progress'] as num;
                          if (progress != 1) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: CircleAvatar(
                                backgroundColor: Colors.black54,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    value: progress.toDouble(),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyOnlineVideoPlayerThumbnail extends HookConsumerWidget {
  const MyOnlineVideoPlayerThumbnail({Key? key, required this.videoMessage})
      : super(key: key);
  final types.VideoMessage videoMessage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final mq = MediaQuery.of(context).size;
    final loading = useState(false);
    final videoThumbnail = useFuture(
      useMemoized(() => generateThumbnail(videoMessage.uri)),
    );
    return SizedBox(
      height: mq.height * 0.3,
      width: mq.width * 0.5,
      child: Builder(
        builder: (context) {
          if (!(videoThumbnail.connectionState == ConnectionState.done)) {
            return const Center(
              child: SpinKitChasingDots(
                color: Colors.red,
              ),
            );
          }
          return Hero(
            tag: 'video${videoMessage.id}',
            child: GestureDetector(
              onTap: () async {
                final videoPlayerController = VideoPlayerController.networkUrl(
                  Uri.parse(
                    videoMessage.uri,
                  ),
                );

                loading.value = true;
                await videoPlayerController.initialize();
                final chewieController = ChewieController(
                  videoPlayerController: videoPlayerController,
                  allowFullScreen: true,
                  allowedScreenSleep: false,
                  allowMuting: true,
                  allowPlaybackSpeedChanging: false,
                  autoPlay: true,

                  showOptions: false,
                  materialProgressColors: ChewieProgressColors(
                    backgroundColor: Colors.white,
                    bufferedColor: Colors.grey.withOpacity(0.7),
                    handleColor: colorScheme.primary,
                    playedColor: colorScheme.primaryContainer,
                  ),
                  // cupertinoProgressColors: ChewieProgressColors()
                  looping: false,
                  zoomAndPan: false,
                );
                loading.value = false;

                ref.read(navigationBarProvider.notifier).update((state) => 0.0);
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MyVideoPlayerScreen(
                          videoMessage: videoMessage,
                          videoPlayerController: videoPlayerController,
                          chewieController: chewieController,
                        );
                      },
                    ),
                  );
                }
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.memory(
                    videoThumbnail.data!,
                    fit: BoxFit.fill,
                  ),
                  Positioned.fill(
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: Builder(
                          builder: (context) {
                            if (loading.value) {
                              return const SpinKitChasingDots(
                                color: Colors.white,
                              );
                            }
                            return const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyVideoPlayerScreen extends HookConsumerWidget {
  const MyVideoPlayerScreen({
    Key? key,
    required this.videoMessage,
    required this.videoPlayerController,
    required this.chewieController,
  }) : super(key: key);
  final types.VideoMessage videoMessage;
  final VideoPlayerController videoPlayerController;
  final ChewieController chewieController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        return () {
          videoPlayerController.dispose();
          chewieController.dispose();
        };
      },
      const [],
    );
    return WillPopScope(
      onWillPop: () async {
        ref.read(navigationBarProvider.notifier).update((state) => 0.1);
        return true;
      },
      child: Hero(
        tag: 'video${videoMessage.id}',
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(
              '${LocaleKeys.sentAt.tr()} ${DateFormat.yMd(
                context.locale.languageCode,
              ).add_jm().format(DateTime.fromMillisecondsSinceEpoch(videoMessage.createdAt!))} ${LocaleKeys.by.tr()} ${videoMessage.author.firstName}',
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: Chewie(
                    controller: chewieController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
