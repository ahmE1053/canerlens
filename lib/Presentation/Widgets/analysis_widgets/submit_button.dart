import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/providers/language_provider.dart';
import '../../../generated/locale_keys.g.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.mq,
    required this.img,
    required this.onTap,
  });

  final Size mq;
  final File? img;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mq.width * 0.4,
      height: mq.height * 0.05,
      child: ElevatedButton(
        onPressed: img == null ? null : onTap,
        child: Consumer(
          builder: (context, ref, child) {
            ref.watch(languageProvider);
            return FittedBox(
              child: Text(
                LocaleKeys.startDiag.tr(),
                style: TextStyle(fontSize: mq.width * 0.06),
              ),
            );
          },
        ),
      ),
    );
  }
}
