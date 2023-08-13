import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/providers/language_provider.dart';
import '../../../generated/locale_keys.g.dart';

class SelectImageButton extends StatelessWidget {
  const SelectImageButton({
    super.key,
    required this.mq,
    required this.onTap,
  });

  final Size mq;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mq.width * 0.4,
      height: mq.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
          splashFactory: NoSplash.splashFactory,
          // surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        onPressed: onTap,
        child: Consumer(
          builder: (context, ref, child) {
            ref.watch(languageProvider);
            return FittedBox(
              child: Text(
                LocaleKeys.selectImg.tr(),
                style: TextStyle(fontSize: mq.width * 0.06),
              ),
            );
          },
        ),
      ),
    );
  }
}
