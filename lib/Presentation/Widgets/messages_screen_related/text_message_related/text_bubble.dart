import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class MyTextBubbleBuilder extends StatelessWidget {
  const MyTextBubbleBuilder(
      {Key? key,
      required this.child,
      required this.nextMessageInGroup,
      required this.isSender})
      : super(key: key);
  final Widget child;
  final bool nextMessageInGroup, isSender;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Bubble(
      color: isSender ? colorScheme.primary : colorScheme.secondary,
      nip: nextMessageInGroup
          ? BubbleNip.no
          : isSender
              ? BubbleNip.rightBottom
              : BubbleNip.leftBottom,
      margin: nextMessageInGroup
          ? const BubbleEdges.symmetric(horizontal: 6)
          : null,
      child: child,
    );
  }
}
