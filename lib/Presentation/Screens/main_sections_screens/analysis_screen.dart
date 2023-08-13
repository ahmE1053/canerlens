import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:medapp4/core/utilities/widget_helper.dart';

import '../../../core/providers/language_provider.dart';
import '../../../core/utilities/context_extensions.dart';
import '../../../data/data%20source/patient_remote_date_source.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../core/providers/analysis_screen_scaffold_key.dart';
import '../../../core/router/app_router.dart';

@RoutePage()
class AnalysisScreen extends HookConsumerWidget {
  const AnalysisScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    final scaffoldKey = ref.read(analysisScreenScaffoldKey);
    ref.watch(patientRemoteDataSourceProvider);
    return AutoTabsRouter(
      routes: const [
        SkinRoute(),
        LungRoute(),
        ProfileRoute(),
        InfoRoute(),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabRouter = AutoTabsRouter.of(context);
        final currentIndex = tabRouter.activeIndex;
        return Scaffold(
          key: scaffoldKey,
          body: Stack(
            fit: StackFit.expand,
            children: [
              child,
              if (currentIndex < 2)
                PositionedDirectional(
                  top: 12,
                  start: 12,
                  child: SafeArea(
                    child: IconButton(
                      onPressed: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: context.width * 0.07,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      if (currentIndex != 0) {
                        tabRouter.setActiveIndex(0);
                      }
                      context.popRoute();
                    },
                    selected: currentIndex == 0,
                    leading: const Icon(
                      FontAwesome.hand_dots,
                    ),
                    title: const Text(
                      LocaleKeys.drawerSkin,
                    ).tr(),
                  ),
                  ListTile(
                    onTap: () {
                      if (currentIndex != 1) {
                        tabRouter.setActiveIndex(1);
                      }
                      context.popRoute();
                    },
                    leading: const Icon(
                      FontAwesome.lungs_virus,
                    ),
                    selected: currentIndex == 1,
                    title: const Text(
                      LocaleKeys.drawerLung,
                    ).tr(),
                  ),
                  ListTile(
                    onTap: () {
                      if (currentIndex != 2) {
                        tabRouter.setActiveIndex(2);
                      }
                      context.popRoute();
                    },
                    leading: const Icon(
                      FontAwesome.user,
                    ),
                    selected: currentIndex == 2,
                    title: const Text(
                      LocaleKeys.drawerProfile,
                    ).tr(),
                  ),
                  ListTile(
                    onTap: () {
                      if (currentIndex != 3) {
                        tabRouter.setActiveIndex(3);
                      }
                      context.popRoute();
                    },
                    leading: const Icon(
                      FontAwesome.circle_info,
                    ),
                    selected: currentIndex == 3,
                    title: const Text(
                      LocaleKeys.drawerInfo,
                    ).tr(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
