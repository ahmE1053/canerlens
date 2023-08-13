import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../router/app_router.dart';
import '../../domain/entities/normal.dart';
import '../../generated/locale_keys.g.dart';
import 'translate.dart';

class TextTranslator {
  const TextTranslator(this.context, this.normals);
  final BuildContext context;
  final List<Normal> normals;
  Future<void> wrongImageTextGenerator(ValueNotifier<bool> loading) async {
    if (normals.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(LocaleKeys.wrongImageScreenTitle.tr()),
          content: Text(LocaleKeys.wrongImageLastPart.tr()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                LocaleKeys.ok.tr(),
              ),
            ),
          ],
        ),
      );
      return;
    }
    String? results = '';
    if (context.locale == const Locale('ar')) {
      results = await arabicTextGenerator(loading);
    } else {
      results = englishTextGenerator();
    }
    if (results == null) {
      return;
    }
    if (context.mounted) {
      context.pushRoute(
        WrongImageRoute(
          text: results,
        ),
      );
    }
  }

  Future<String?> arabicTextGenerator(ValueNotifier<bool> loading) async {
    String results = '';
    final willNotDownload = ValueNotifier(false);
    for (int i = 0; i < normals.length; i++) {
      final text = normals[i].text.toLowerCase();
      if (text == 'skin' || text == 'flesh' || text == 'pattern') continue;
      final translatedResult =
          await translate(text, context, loading, willNotDownload);
      if (translatedResult == null) {
        return null;
      }
      if (i == normals.length - 1) {
        results += translatedResult;
        break;
      }
      results += '$translatedResult, ';
    }
    return results;
  }

  String englishTextGenerator() {
    String results = '';
    for (int i = 0; i < normals.length; i++) {
      final text = normals[i].text.toLowerCase();
      if (text == 'skin' || text == 'flesh' || text == 'pattern') continue;
      if (i == normals.length - 1) {
        results += text;
        break;
      }
      results += '$text, ';
    }

    return results;
  }
}
