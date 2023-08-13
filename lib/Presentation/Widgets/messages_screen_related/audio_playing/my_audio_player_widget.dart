import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:just_audio/just_audio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import 'seek_bar_widget.dart';

class MyAudioPlayer extends HookConsumerWidget {
  const MyAudioPlayer({
    Key? key,
    required this.audioMessage,
  }) : super(key: key);
  final types.AudioMessage audioMessage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final mq = MediaQuery.of(context).size;
    //the audio player
    final player = useMemoized(() => AudioPlayer());
    final duration = useFuture(
      useMemoized(
        () => audioMessage.metadata!['type'] == 'online'
            ? player.setUrl(audioMessage.uri)
            : player.setFilePath(audioMessage.uri),
      ),
    );

    /// used when buffering
    final loading = useState(false);

    //used to change between play and pause button
    final isPlaying = useState(player.playing);

    //handle if the audio is still loading
    if (!(duration.connectionState == ConnectionState.done)) {
      return SizedBox(
        width: mq.width * 0.5,
        height: 70,
        child: const SpinKitChasingDots(
          color: Colors.white,
        ),
      );
    }
    useEffect(
      () {
        //used to listen to if the audio is playing or not
        //and to cancel the stream when the widget is disposed
        final playingStream = player.playerStateStream.listen(
          (event) {
            if (event.processingState == ProcessingState.buffering) {
              loading.value = true;
            } else {
              loading.value = false;
            }

            //changes the playing icon
            isPlaying.value = event.playing;

            //if the audio is completed reset the player and stop it
            //to release the resources used by player.
            if (event.processingState == ProcessingState.completed) {
              player.seek(Duration.zero);
              player.stop();
            }
          },
        );

        return () {
          //cancels the stream and disposes the player
          playingStream.cancel();
          player.dispose();
        };
      },
      const [],
    );

    return SizedBox(
      height: 70,
      width: mq.width * 0.5,
      child: Row(
        children: [
          //the play and pause button
          SizedBox(
            width: 50,
            child: Builder(
              builder: (context) {
                if (loading.value) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SpinKitChasingDots(
                      color: audioMessage.author.id ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? colorScheme.onPrimary.withOpacity(0.7)
                          : colorScheme.onSecondary.withOpacity(0.7),
                    ),
                  );
                }
                return IconButton(
                  onPressed: () async {
                    if (!isPlaying.value) {
                      await player.play();
                    } else {
                      await player.pause();
                    }
                  },
                  icon: Icon(
                    isPlaying.value ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          //the seek bar
          Expanded(
            child: SeekBar(player, audioMessage),
          ),
        ],
      ),
    );
  }
}
