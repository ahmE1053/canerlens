import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../core/providers/language_provider.dart';
import '../../../data/data source/patient_remote_date_source.dart';
import '../../../generated/locale_keys.g.dart';

@RoutePage()
class IntroScreen extends ConsumerWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    List<PageViewModel> introPageList = [
      PageViewModel(
        image: Center(
          child: Lottie.asset(
            'assets/lottie/medical.json',
          ),
        ),
        title: LocaleKeys.introPage1Title.tr(),
        body: LocaleKeys.introPage1Body.tr(),
      ),
      PageViewModel(
        image: Center(
          child: Image.asset(
            'assets/images/lung2.jpg',
          ),
        ),
        title: LocaleKeys.introPage2Title.tr(),
        body: LocaleKeys.introPage2Body.tr(),
      ),
      PageViewModel(
        image: Center(
          child: Image.asset(
            'assets/images/seek_doctor.jpg',
          ),
        ),
        title: LocaleKeys.introPage3Title.tr(),
        body: LocaleKeys.introPage3Body.tr(),
      ),
      PageViewModel(
        image: Center(
          child: Image.asset(
            'assets/images/skin3.jpg',
          ),
        ),
        title: LocaleKeys.introPage4Title.tr(),
        body: LocaleKeys.introPage4Body.tr(),
      ),
    ];
    ref.watch(languageProvider);
    return ref.watch(patientRemoteDataSourceProvider).when(
          data: (data) {
            return Stack(
              children: [
                IntroductionScreen(
                  safeAreaList: const [false, false, true, false],
                  pages: List<PageViewModel>.from(introPageList),
                  allowImplicitScrolling: true,
                  showBackButton: true,
                  showDoneButton: true,
                  showNextButton: true,
                  showSkipButton: false,
                  done: Text(LocaleKeys.done.tr()),
                  next: Text(LocaleKeys.next.tr()),
                  back: const Icon(Icons.arrow_back),
                  onDone: () {
                    SharedPreferences.getInstance().then(
                      (value) {
                        value.setBool('isDone', true);
                      },
                    );
                    if (data == null) {
                      context.router.replaceNamed('/auth');
                    } else {
                      context.router.replaceNamed('/home');
                    }
                    return;
                  },
                ),
                SafeArea(
                  child: TextButton(
                    onPressed: () async {
                      await context.setLocale(
                        context.locale == const Locale('en')
                            ? const Locale('ar')
                            : const Locale('en'),
                      );
                      ref.read(languageProvider.notifier).update(
                            (state) => const Uuid().v4(),
                          );
                    },
                    child: Text(
                      LocaleKeys.translate.tr(),
                    ),
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) => const Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          ),
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
  }
}
