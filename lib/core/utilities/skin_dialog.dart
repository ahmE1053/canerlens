import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/skin_percentage.dart';
import '../../generated/locale_keys.g.dart';

Future<void> showSkinResults(
    BuildContext context, SkinPercentage skinPercentage) async {
  final mq = MediaQuery.of(context).size;
  await showDialog(
    context: context,
    builder: (context) {
      return SizedBox(
        width: mq.width * 0.5,
        child: AlertDialog(
          title: Text(LocaleKeys.results.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('${LocaleKeys.name.tr()}: ${skinPercentage.name}'),
              ),
              ListTile(
                title: Text(
                    '${LocaleKeys.percentage.tr()}: ${(skinPercentage.percentage * 100).toStringAsFixed(2)} %'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text(
                LocaleKeys.ok.tr(),
              ),
            ),
          ],
        ),
      );
    },
  );
}
