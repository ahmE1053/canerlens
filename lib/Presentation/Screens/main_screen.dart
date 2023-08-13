import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:medapp4/core/utilities/context_extensions.dart';
import 'package:medapp4/core/utilities/widget_helper.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../core/providers/language_provider.dart';
import '../../core/providers/navigation_bar_provider.dart';
import '../../core/router/app_router.dart';
import '../../generated/locale_keys.g.dart';

@RoutePage()
class MainScreen extends ConsumerWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    final mq = MediaQuery.of(context).size;
    return AutoTabsRouter(
      routes: const [
        AnalysisRoute(),
        DoctorsRoute(),
        AppointmentsRoute(),
        MessagesRoute(),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        return Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     ref.read(appRouterProvider).navigateNamed('/home/messages');
          //     // final data =
          //     //     (await FirebaseFirestore.instance.collection('doctors').get())
          //     //         .docs;
          //     // final doctorsList = data.map(
          //     //   (e) => Doctor.fromJson(
          //     //     e.data(),
          //     //   ),
          //     // );
          //     // int iForOffline = 0;
          //     // int iForOnline = 0;
          //     // final a = List<Doctor>.from(doctorsList.map(
          //     //   (e) {
          //     //     iForOffline = 0;
          //     //     iForOnline = 0;
          //     //     return e.copyWith(
          //     //       availableOn: e.availableOn.copyWith(
          //     //           onlineAvailability: e.availableOnline
          //     //               ? e.availableOn.onlineAvailability!
          //     //                   .map(
          //     //                     (e) => e.copyWith(
          //     //                       day: DateTime.now().add(
          //     //                         Duration(
          //     //                           days: iForOnline++,
          //     //                         ),
          //     //                       ),
          //     //                     ),
          //     //                   )
          //     //                   .toList()
          //     //               : null,
          //     //           offlineAvailability: e.availableOffline
          //     //               ? e.availableOn.offlineAvailability!
          //     //                   .map(
          //     //                     (e) => e.copyWith(
          //     //                       day: DateTime.now().add(
          //     //                         Duration(
          //     //                           days: iForOffline++,
          //     //                         ),
          //     //                       ),
          //     //                     ),
          //     //                   )
          //     //                   .toList()
          //     //               : null),
          //     //     );
          //     //   },
          //     // ));
          //     // for (var doctor in a) {
          //     //   await FirebaseFirestore.instance
          //     //       .collection('doctors')
          //     //       .doc(doctor.id)
          //     //       .set(
          //     //         doctor.toJson(),
          //     //       );
          //     // }
          //   },
          // ),
          body: child,
          bottomNavigationBar: Consumer(
            builder: (context, ref, child) {
              final tabsRouter = AutoTabsRouter.of(context);
              final navBarHeight = ref.watch(navigationBarProvider);
              return AnimatedSize(
                duration: const Duration(milliseconds: 250),
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(maxHeight: mq.height * navBarHeight),
                  child: SalomonBottomBar(
                    currentIndex: tabsRouter.activeIndex,
                    selectedItemColor: context.colorScheme.primary,
                    onTap: (index) {
                      tabsRouter.setActiveIndex(index);
                    },
                    margin: const EdgeInsets.all(16),
                    items: [
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.home_outlined),
                        activeIcon: const Icon(Icons.home),
                        title: const Text(LocaleKeys.homeNavBar).tr(),
                      ),
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.person_outline),
                        activeIcon: const Icon(Icons.person),
                        title: const Text(LocaleKeys.doctorNavBar).tr(),
                      ),
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.calendar_month_outlined),
                        activeIcon: const Icon(Icons.calendar_month),
                        title: const Text(LocaleKeys.appointmentsNavBar).tr(),
                      ),
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.email_outlined),
                        activeIcon: const Icon(Icons.email),
                        title: const Text(LocaleKeys.messagesNavBar).tr(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ).wrapWithKeyboardRemover;
      },
    );
  }
}
