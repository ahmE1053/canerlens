import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:medapp4/core/providers/shared_preferences_provider.dart';
import 'package:medapp4/core/router/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utilities/notification_related/notifications_settings.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  firebaseMessagingInitialization();
  await EasyLocalization.ensureInitialized();
  final isLightMode =
      (await SharedPreferences.getInstance()).getBool('isLightMode');
  runApp(
    ProviderScope(
      child: EasyLocalization(
        path: 'assets/l10n',
        supportedLocales: const [
          Locale('ar'),
          Locale('en'),
        ],
        saveLocale: true,
        fallbackLocale: const Locale('en'),
        child: MyApp(
          isLightMode: isLightMode,
        ),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({
    Key? key,
    this.isLightMode,
  }) : super(key: key);
  final bool? isLightMode;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(sharedPreferencesProvider).when(
          data: (data) {
            return MaterialApp.router(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              color: Colors.red,
              theme: ThemeData(
                brightness: ref.watch(themeProvider),
                useMaterial3: true,
                colorSchemeSeed: const Color(0xff512793),
              ),
              routerConfig: ref.read(appRouterProvider).config(),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => const Center(
            child: Text('Error'),
          ),
        );
  }
}
