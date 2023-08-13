import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:medapp4/core/providers/shared_preferences_provider.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/consts/app_typography.dart';
import '../../../core/providers/analysis_screen_scaffold_key.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/language_provider.dart';
import '../../../data/data source/patient_remote_date_source.dart';
import '../../widgets/my_list_tile.dart';

@RoutePage()
class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(patientRemoteDataSourceProvider);
    final mq = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final listOfSetting =
        ref.read(authenticationProvider.notifier).addToListTiles(context);
    final scaffoldKey = ref.read(analysisScreenScaffoldKey);
    final sharedPref = ref.watch(sharedPreferencesProvider);
    String privacy = '';
    LocaleKeys.privacySubtitle
        .tr()
        .split(
          '\\n',
        )
        .forEach(
          (e) => privacy += '$e\n',
        );
    privacy = privacy.substring(0, privacy.length - 2);
    ref.watch(languageProvider);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          LocaleKeys.drawerProfile.tr(),
        ),
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authenticationProvider.notifier).signOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: userInfo.when(
        data: (data) {
          final userInfo = data!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: theme.colorScheme.primaryContainer,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: mq.width * 0.3,
                        child: Lottie.asset(
                          'assets/lottie/security.json',
                          repeat: true,
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: FittedBox(
                            child: Text(
                              LocaleKeys.privacyTitle.tr(),
                              style: AppTypography.semiHeadlineSize(context),
                            ),
                          ),
                          subtitle: FittedBox(
                            child: Text(
                              privacy,
                              style: AppTypography.bodySize(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  LocaleKeys.infoAboutYou.tr(),
                  style: AppTypography.headlineSize(context),
                ),
                const SizedBox(height: 16),
                ListTile(
                  tileColor: theme.colorScheme.primaryContainer,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  title: Text(
                    LocaleKeys.birthday.tr(),
                    style: AppTypography.semiHeadlineSize(context),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd(
                      context.locale.languageCode,
                    ).format(userInfo.dateOfBirth),
                    style: AppTypography.bodySize(context),
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  tileColor: theme.colorScheme.primaryContainer,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  title: Text(
                    LocaleKeys.appointmentsNavBar.tr(),
                    style: AppTypography.semiHeadlineSize(context),
                  ),
                  subtitle: Text(
                    '${LocaleKeys.numberOfAppointments.tr()} ${userInfo.appointments.length}',
                    style: AppTypography.bodySize(context),
                  ),
                  onTap: () {
                    //TODO: here
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  LocaleKeys.drawerSettings.tr(),
                  style: AppTypography.headlineSize(context),
                ),
                const SizedBox(height: 16),
                SwitchListTile.adaptive(
                  value: ref.watch(themeProvider) == Brightness.dark,
                  onChanged: (value) {
                    if ((sharedPref.value!.getBool('isLightMode') ?? true)) {
                      sharedPref.value!.setBool('isLightMode', false);
                      ref
                          .read(themeProvider.notifier)
                          .update((state) => Brightness.dark);
                      return;
                    }
                    sharedPref.value!.setBool('isLightMode', true);
                    ref
                        .read(themeProvider.notifier)
                        .update((state) => Brightness.light);
                  },
                  title: FittedBox(
                    alignment: AlignmentDirectional.centerStart,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      LocaleKeys.changeTheme.tr(),
                      style: AppTypography.semiHeadlineSize(context),
                    ),
                  ),
                  subtitle: FittedBox(
                    alignment: AlignmentDirectional.centerStart,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      (sharedPref.value!.getBool('isLightMode') ?? true)
                          ? LocaleKeys.changeThemeDarkText.tr()
                          : LocaleKeys.changeThemeLightText.tr(),
                      style: AppTypography.bodySize(context),
                    ),
                  ),
                  tileColor: theme.colorScheme.primaryContainer,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  children: listOfSetting.asMap().entries.map(
                    (e) {
                      return MyListTile(
                        tilePlace: e.key == listOfSetting.length - 1 ||
                                listOfSetting.length == 2
                            ? ListTilePlace.last
                            : ListTilePlace.middle,
                        title: e.value['title'] as String,
                        subtitle: e.value['subtitle'] as String,
                        tileColor: theme.colorScheme.primaryContainer,
                        textColor: e.value['textColor'] as Color?,
                        onTap: e.value['onTap'] as void Function()?,
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => const Center(
          child: FittedBox(
            child: Text('An error occurred. Please try again later.'),
          ),
        ),
        loading: () => Center(
          child: SpinKitDoubleBounce(
            color: theme.colorScheme.primaryContainer,
          ),
        ),
      ),
    );
  }
}
