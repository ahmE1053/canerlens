import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension MediaQueryHelper on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  double get topPadding => MediaQuery.viewPaddingOf(this).top;
  double get bottomPadding => MediaQuery.viewPaddingOf(this).bottom;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Color get primaryColor => colorScheme.primary;
  Color get secondaryColor => colorScheme.secondary;
  Color get primaryContainerColor => colorScheme.primaryContainer;
  Color get secondaryContainerColor => colorScheme.secondaryContainer;
  Color get errorColor => colorScheme.error;
  bool get isPortrait => MediaQuery.orientationOf(this) == Orientation.portrait;
  bool get isArabic => locale == const Locale('ar');
  void setToArabic() => setLocale(const Locale('ar'));
  void setToEnglish() => setLocale(const Locale('en'));
}
