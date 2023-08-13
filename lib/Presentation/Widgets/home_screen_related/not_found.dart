import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medapp4/core/utilities/context_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

class NotFound extends StatelessWidget {
  const NotFound({
    Key? key,
    this.text = 'Your search didn\'t come up \nwith any results',
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: context.height * 0.5,
          maxWidth: context.width * 0.8,
        ),
        // height:
        // width:
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Lottie.asset(
              'assets/lottie/not_found.json',
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 8),
            FittedBox(
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
