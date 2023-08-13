import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:medapp4/core/consts/app_typography.dart';
import 'package:medapp4/core/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../core/router/app_router.dart';

@RoutePage()
class SplashScreen extends HookConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          await Future.delayed(const Duration(seconds: 2));
          final sharedPref = await SharedPreferences.getInstance();
          final firstTimeChecker = sharedPref.getBool('isDone');
          if (!(firstTimeChecker ?? false)) {
            ref.read(appRouterProvider).replaceNamed(
                  '/intro',
                );
            return;
          }
          if (FirebaseAuth.instance.currentUser == null) {
            final skippedAuth = sharedPref.getBool('skipAuth');
            print(skippedAuth);
            if ((skippedAuth ?? false)) {
              ref.read(appRouterProvider).replaceNamed('/analysisWithoutAuth');
              return;
            }
            ref.read(appRouterProvider).replaceNamed(
                  '/auth',
                );
            return;
          }

          ref.read(appRouterProvider).replaceNamed(
                '/home',
              );
        },
      );
      return null;
    }, const []);
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: mq.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                child: Lottie.asset(
                  'assets/lottie/splash.json',
                ),
              ),
              FittedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: mq.width * 0.0),
                  child: Text(
                    'Cancer Lens',
                    style: AppTypography.bigHeadlineSize(context),
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
