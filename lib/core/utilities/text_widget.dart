import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyCustomTextWidget extends ConsumerWidget {
  const MyCustomTextWidget(
    this.text,
    this.style, {
    Key? key,
  }) : super(key: key);
  final String text;
  final TextStyle style;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      text,
      style: style,
    );
  }
}
