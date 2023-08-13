import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/providers/language_provider.dart';
import '../../../generated/locale_keys.g.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = context.locale == const Locale('ar')
        ? const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          );

    return SafeArea(
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        child: Column(
          children: [
            ListTile(
              style: ListTileStyle.drawer,
              title: Consumer(
                builder: (context, ref, child) {
                  ref.watch(languageProvider);

                  return Text(LocaleKeys.drawerSettings.tr());
                },
              ),
              leading: const Icon(Icons.settings),
              onTap: () {
                //TODO
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => const SettingScreen(),
                //   ),
                // );
              },
            )
          ],
        ),
      ),
    );
  }
}
