import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/consts/app_typography.dart';
import '../../../core/providers/language_provider.dart';

@RoutePage()
class BookAppointmentSuccessScreen extends ConsumerWidget {
  const BookAppointmentSuccessScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Lottie.asset('assets/lottie/success.json', repeat: false),
              const SizedBox(height: 16),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  LocaleKeys.appointmentRegisterSuccess.tr(),
                  style: AppTypography.semiHeadlineSize(context),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                child: ElevatedButton(
                  onPressed: () {
                    context.router.popUntilRoot();
                  },
                  child: Text(
                    LocaleKeys.goHome.tr(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
