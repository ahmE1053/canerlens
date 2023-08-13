import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record/record.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../core/consts/app_typography.dart';
import '../../../../core/providers/voice_path_provider.dart';
import '../../../../core/utilities/duration_converter.dart';
import '../../../../data/data source/chats_remote_data_source.dart';
import '../../../../domain/entities/chat.dart';
import 'main_bottom_widget.dart';

class VoiceRecordingWidget extends HookConsumerWidget {
  const VoiceRecordingWidget({
    Key? key,
    required this.widgetState,
    required this.recorder,
    required this.chatInfo,
  }) : super(key: key);
  final ChatInfo chatInfo;
  final ValueNotifier<BottomWidgetState> widgetState;
  final Record recorder;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final duration = useState(Duration.zero);
    final stream = useMemoized(() => voiceRecorderDurationStream(duration));
    final recorderState = useState(RecordState.record);
    useEffect(
      () {
        final recorderStream = recorder.onStateChanged().listen(
          (event) {
            recorderState.value = event;
          },
        );
        return () {
          recorderStream.cancel();
          stream.cancel();
          recorder.dispose();
        };
      },
      const [],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton.filled(
                      onPressed: () {
                        stream.cancel();
                        recorder.dispose();
                        widgetState.value = BottomWidgetState.text;
                      },
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton.outlined(
                      onPressed: () async {
                        if (recorderState.value == RecordState.record) {
                          await recorder.pause();
                          recorderState.value = RecordState.pause;
                          stream.pause();
                        } else {
                          await recorder.resume();
                          recorderState.value = RecordState.record;
                          stream.resume();
                        }
                      },
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                      ),
                      icon: Icon(
                        recorderState.value == RecordState.record
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),
                    IconButton.filled(
                      onPressed: () async {
                        if (duration.value.inSeconds < 1) {
                          stream.cancel();
                          recorder.dispose();
                          widgetState.value = BottomWidgetState.text;
                          return;
                        }
                        await recorder.stop();
                        final path = ref.read(voicePathProvider);
                        ref.read(chatNotifierProvider).addVoice(
                              path!,
                              duration.value,
                            );
                        stream.cancel();
                        recorder.dispose();
                        widgetState.value = BottomWidgetState.text;
                      },
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                      ),
                      icon: const Icon(
                        Icons.send,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                formatDurationForSeekBar(duration.value),
                style: AppTypography.semiBodySize(
                  context,
                  colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }
}

StreamSubscription<int> voiceRecorderDurationStream(
        ValueNotifier<Duration> duration) =>
    Stream.periodic(
      const Duration(seconds: 1),
      (computationCount) {
        return computationCount + 1;
      },
    ).listen(
      (event) {
        duration.value = Duration(seconds: event);
      },
    );
