import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../core/consts/app_typography.dart';
import '../../../../core/utilities/duration_converter.dart';

class SeekBar extends HookWidget {
  const SeekBar(this.player, this.audioMessage, {Key? key}) : super(key: key);
  final AudioPlayer player;
  final AudioMessage audioMessage;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    ///used to indicate the value of where the audio is
    ///between 0.0 and 1.0
    final position = useState(0.0);

    ///this does the same thing but in a value between
    ///0.0 and constraints.maxWidth-30
    ///30 being the radius of the seekbar circle
    ///this is used to change to location of this circle and
    ///the progress of the audio in general
    var positionInPixels = 0.0;

    ///the audio will pause if the user uses the seekbar
    ///this is used to continue playing the audio if the audio after the
    ///seeking is done
    final wasPlaying = useState(false);

    useEffect(() {
      /// this is used to change the position of the seekbar
      /// to make the movement animated.
      final positionStream = player.positionStream.listen(
        (event) {
          if (player.duration == null) {
            position.value = 0.0;
            return;
          }
          //gets the percentage of the audio (from 0 to 1)
          position.value = event.inSeconds / player.duration!.inSeconds;
        },
      );
      return () {
        //cancels this stream;
        positionStream.cancel();
      };
    }, const []);

    return LayoutBuilder(
      builder: (context, constraints) {
        ///used to remove the circle radius from the width
        ///otherwise the circle will go out of bounds
        final width = constraints.maxWidth - 30;

        ///this the used in seeking because when the
        ///user is dragging the circle it adds or removes the
        ///primary delta to this number and then
        ///converts it to a value between 0 and 1
        ///and assigns it to [position]
        positionInPixels = width * position.value;

        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Center(
              child: Container(
                height: 3,
                color: Colors.grey,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                height: 3,
                //todo: wtf does 1 mean here
                color: audioMessage.author.id == '1'
                    ? colorScheme.onPrimary
                    : colorScheme.onSecondary,
                width: constraints.maxWidth * position.value,
              ),
            ),
            Positioned(
              left: width * position.value,
              width: 30,
              child: Center(
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    ///if the player is playing
                    ///pause it and change wasPlaying to true
                    ///so it can resume after the dragging ends
                    if (player.playing) {
                      wasPlaying.value = true;
                      player.pause();
                    }

                    ///this does not let the variable go below zero or above than [width]
                    ///if the user decided to keep dragging out the bounds
                    positionInPixels = max(
                      0,
                      min(
                        width,
                        (positionInPixels + details.primaryDelta!),
                      ),
                    );

                    /// as mentioned before this changes the position values
                    /// relative to the value of [positionInPixels] and [width]
                    position.value = positionInPixels.getRangeFromAnotherRange(
                      0.0,
                      width,
                      0.0,
                      1.0,
                    );
                  },
                  onHorizontalDragEnd: (details) {
                    /// gets the duration of the song
                    /// needs the user to start playing first to appear
                    final duration = player.duration!.inSeconds;

                    /// seeks to a percentage of the total duration based on
                    /// the value of position
                    player.seek(
                      Duration(
                        seconds: (duration * position.value).round(),
                      ),
                    );

                    /// resumes the audio if the audio was playing before seeking
                    if (wasPlaying.value) {
                      player.play();
                      wasPlaying.value = false;
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: audioMessage.author.id == '1'
                          ? colorScheme.onPrimary
                          : colorScheme.onSecondary,
                    ),
                    height: 30,
                  ),
                ),
              ),
            ),

            /// the text displaying the progress of the audio in mm:ss format
            Positioned(
              right: 0,
              bottom: 0,
              height: 20,
              child: Row(
                children: [
                  FittedBox(
                    child: Text(
                      formatDurationForSeekBar(
                        Duration(
                          seconds: position.value == 0
                              ? player.duration!.inSeconds
                              : (player.duration!.inSeconds * position.value)
                                  .round(),
                        ),
                      ),
                      style: AppTypography.smallSize(
                        context,
                        audioMessage.author.id == '1'
                            ? colorScheme.onPrimary
                            : colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FittedBox(
                    child: Text(
                      DateFormat.jm(
                        context.locale.languageCode,
                      ).format(
                        DateTime.fromMillisecondsSinceEpoch(
                          audioMessage.createdAt!,
                        ),
                      ),
                      style: AppTypography.smallSize(
                        context,
                        audioMessage.author.id == '1'
                            ? colorScheme.onPrimary.withOpacity(0.7)
                            : colorScheme.onSecondary.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

extension Range<T extends double> on num {
  T getRangeFromAnotherRange(T oldMin, T oldHigh, T newMin, T newHigh) {
    T newValue = ((this - oldMin) / (oldHigh - oldMin) * (newHigh - newMin) +
        newMin) as T;
    return newValue;
  }

  T getRangeFromZeroToOne(T min, T high) {
    T newValue = ((this - 0.0) / (1.0 - 0.0) * (high - min) + min) as T;
    return newValue;
  }
}
