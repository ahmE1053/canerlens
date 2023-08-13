import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/consts/app_typography.dart';
import '../../../generated/locale_keys.g.dart';

@RoutePage()
class WrongImageScreen extends StatelessWidget {
  const WrongImageScreen({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.wrongImageScreenTitle.tr()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/confused.json',
              ),
              const SizedBox(height: 16),
              Text(
                '${LocaleKeys.wrongImageFirstPart.tr()}\n'
                '$text\n'
                '${LocaleKeys.wrongImageLastPart.tr()}',
                style: AppTypography.bodySize(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Align(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(LocaleKeys.goBack.tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
