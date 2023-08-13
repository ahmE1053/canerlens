import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

Future<Widget?> errorDialog(String errorText, BuildContext context) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: FittedBox(
          child: Text(
            errorText,
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              LocaleKeys.ok.tr(),
            ),
          )
        ],
      ),
    );
