import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) => SharedPreferences.getInstance());

final themeProvider = StateProvider<Brightness>(
  (ref) {
    final sharedRef = ref.watch(sharedPreferencesProvider);
    if (!sharedRef.hasValue) {
      return Brightness.light;
    }
    if (sharedRef.value!.getBool('isLightMode') ?? true) {
      return Brightness.light;
    }
    return Brightness.dark;
  },
);
