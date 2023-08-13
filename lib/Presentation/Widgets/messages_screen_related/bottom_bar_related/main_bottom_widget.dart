import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:record/record.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../domain/entities/chat.dart';
import 'normal_text_field.dart';
import 'voice_recording_widget.dart';

class MainBottomWidget extends HookWidget {
  const MainBottomWidget({
    Key? key,
    required this.chatInfo,
  }) : super(key: key);
  final ChatInfo chatInfo;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final widgetState = useState(BottomWidgetState.text);
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 250),
    );
    final animationState = useState(AnimationStatus.dismissed);
    final opacity = useMemoized(
        () => Tween<double>(begin: 1.0, end: 0.0).animate(animationController));
    final slide = useMemoized(() =>
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0.0, 0.0))
            .animate(animationController));
    final recorder = useMemoized(() => Record());
    useEffect(
      () {
        if (widgetState.value == BottomWidgetState.text) {
          animationController.reverse();
        } else {
          animationController.forward();
        }
        animationController.addStatusListener((status) {
          animationState.value = status;
        });
        return null;
      },
      [widgetState.value],
    );
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: mq.height * 0.065,
        maxHeight: mq.height * 0.125,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12.0),
        child: Stack(
          children: [
            Builder(
              builder: (context) {
                if (animationState.value == AnimationStatus.completed) {
                  return Container();
                }
                return AnimatedBuilder(
                  animation: opacity,
                  builder: (context, child) {
                    return Opacity(
                      opacity: opacity.value,
                      child: child,
                    );
                  },
                  child: BottomNormalTextField(
                    widgetState: widgetState,
                    recorder: recorder,
                    chatInfo: chatInfo,
                  ),
                );
              },
            ),
            SizedBox(
              height: mq.height * 0.065,
              child: Builder(builder: (context) {
                if (animationState.value == AnimationStatus.dismissed) {
                  return Container();
                }
                return SlideTransition(
                  position: slide,
                  child: VoiceRecordingWidget(
                    widgetState: widgetState,
                    recorder: recorder,
                    chatInfo: chatInfo,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

enum BottomWidgetState {
  text,
  recording,
}
