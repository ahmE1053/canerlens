import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../core/providers/voice_path_provider.dart';
import '../../../../core/utilities/show_snack_bar.dart';
import '../../../../core/utilities/text_direction.dart';
import '../../../../data/data source/chats_remote_data_source.dart';
import '../../../../domain/entities/chat.dart';
import '../../authentication_handling_widgets/my_text_field_widget.dart';
import 'main_bottom_widget.dart';

class BottomNormalTextField extends HookConsumerWidget {
  const BottomNormalTextField({
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
    final textController = useTextEditingController();
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 250),
    );
    final voiceOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.8),
      ),
    );
    final textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1),
      ),
    );
    final voiceOffsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -30.0),
    ).animate(animationController);
    final textSendOffsetAnimation = Tween<Offset>(
      begin: const Offset(50.0, 0.0),
      end: Offset.zero,
    ).animate(animationController);
    final textFieldDirection = useState(TextDirection.ltr);
    final voiceState = useState(true);
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton.filledTonal(
          onPressed: () async {
            ref.read(chatNotifierProvider).addImage(context);
          },
          icon: const Icon(Icons.attach_file),
        ),
        Expanded(
          child: MyTextField(
            textDirection: textFieldDirection.value,
            maxLines: null,
            inputType: TextInputType.multiline,
            controller: textController,
            colorScheme: colorScheme,
            label: LocaleKeys.sendMessage.tr(),
            inputAction: TextInputAction.newline,
            onChanged: (value) {
              launchAnimation(value, voiceState, animationController);
              value = value.trim();
              for (int i = 0; i < value.length; i++) {
                if (value[i] == ' ') continue;
                if (double.tryParse(value[i]) == null) {
                  textFieldDirection.value = getDirection(value[i]);
                  break;
                }
              }
            },
          ),
        ),
        Builder(
          builder: (context) {
            return IconButton.filled(
              onPressed: () async {
                if (!voiceState.value) {
                  ref
                      .read(chatNotifierProvider)
                      .addText(textController.value.text);
                  textController.clear();
                  launchAnimation('', voiceState, animationController);
                  return;
                }
                final status = await Permission.microphone.status;
                if (status.isGranted) {
                  final path = (await getApplicationDocumentsDirectory()).path;
                  final voicePath = '$path/${const Uuid().v4()}.m4a';
                  ref
                      .read(voicePathProvider.notifier)
                      .update((state) => voicePath);
                  await recorder.start(path: voicePath);
                  widgetState.value = BottomWidgetState.recording;
                } else {
                  if (status.isPermanentlyDenied) {
                    if (context.mounted) {
                      showSnackBar(
                        context,
                        'Enable the mic permission from the settings',
                      );
                    }
                    return;
                  }
                  await Permission.microphone.request();
                }
              },
              icon: Stack(
                children: [
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: voiceOpacityAnimation.value,
                        child: Transform.translate(
                          offset: voiceOffsetAnimation.value,
                          child: child!,
                        ),
                      );
                    },
                    child: const FittedBox(
                      child: Icon(
                        Icons.mic,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: textOpacityAnimation.value,
                        child: Transform.translate(
                          offset: textSendOffsetAnimation.value,
                          child: child!,
                        ),
                      );
                    },
                    child: const FittedBox(
                      child: Icon(Icons.send),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void launchAnimation(String text, ValueNotifier<bool> voiceState,
      AnimationController animationController) {
    if (text.isEmpty) {
      voiceState.value = true;
      if (animationController.isCompleted) {
        animationController.reverse();
      }
      return;
    }
    voiceState.value = false;
    if (animationController.isDismissed) {
      animationController.forward();
    }
  }
}
