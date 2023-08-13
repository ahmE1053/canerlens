import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/painters/auth_painter.dart';
import '../../../core/providers/language_provider.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utilities/widget_helper.dart';
import '../../../core/utilities/context_extensions.dart';

enum AuthState {
  signin,
  signup,
}

@RoutePage()
class AuthBackgroundScreen extends HookConsumerWidget {
  const AuthBackgroundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    return AutoTabsRouter(
      transitionBuilder: (_, child, __) => child,
      duration: const Duration(milliseconds: 500),
      routes: const [
        SigninRoute(),
        SignupRoute(),
      ],
      builder: (context, child) {
        final index = AutoTabsRouter.of(context).activeIndex;
        final containerHeight = context.height * (index == 0 ? 0.65 : 0.9);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: containerHeight,
                  width: context.width,
                  child: CustomPaint(
                    painter: MainPainter(),
                  ),
                ),
              ),
              child,
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: ElevatedButton(
                    onPressed: () {
                      SharedPreferences.getInstance().then(
                        (value) => value.setBool('skipAuth', true),
                      );
                      context.router.replaceNamed('/analysisWithoutAuth');
                    },
                    child: Text(LocaleKeys.skipButton.tr()),
                  ),
                ),
              ),
            ],
          ),
        ).wrapWithKeyboardRemover;
      },
    );
  }
}
