import 'package:flutter/material.dart';

import '../platform_channel/platform.dart';

Future<String?> translate(String text, BuildContext context,
    ValueNotifier<bool> loading, ValueNotifier<bool> willNotDownload) async {
  if (willNotDownload.value) {
    return text;
  }
  String? result = await MyPlatform().translate(text, false);
  if (result == null && context.mounted) {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
              'التطبيق يحتاج إلى تحميل بعض الملفات لكي يقوم بعملية الترجمة'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                loading.value = true;
                result = await MyPlatform().translate(text, true);
                loading.value = false;
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم التحميل بنجاح, برجاء إعادة المحاولة'),
                    ),
                  );
                }
              },
              child: const Text('تحميل'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                willNotDownload.value = true;
                result = text;
              },
              child: const Text('إظهار بالانجليزية'),
            ),
          ],
        );
      },
    );
  }
  return result;
}
