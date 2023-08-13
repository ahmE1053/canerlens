import 'package:flutter/material.dart';

//Different font sizes for the app that are responsive and not constant
class AppTypography {
  static TextStyle bigHeadlineSize(BuildContext context, [Color? color]) =>
      TextStyle(
        fontSize: _getSize(context).width * 0.1,
        fontWeight: FontWeight.w900,
        color: color ?? _getColorScheme(context).onBackground,
      );
  static TextStyle headlineSize(BuildContext context, [Color? color]) =>
      TextStyle(
        fontSize: _getSize(context).width * 0.08,
        fontWeight: FontWeight.w800,
        color: color ?? _getColorScheme(context).onBackground,
      );

  static TextStyle semiHeadlineSize(BuildContext context, [Color? color]) =>
      TextStyle(
        fontSize: _getSize(context).width * 0.065,
        fontWeight: FontWeight.w600,
        color: color ?? _getColorScheme(context).onBackground,
      );

  static TextStyle bodySize(BuildContext context, [Color? color]) => TextStyle(
        fontSize: _getSize(context).width * 0.055,
        color: color ?? _getColorScheme(context).onBackground,
      );

  static TextStyle semiBodySize(BuildContext context, [Color? color]) =>
      TextStyle(
        fontSize: _getSize(context).width * 0.04,
        color: color ?? _getColorScheme(context).onBackground,
        fontWeight: FontWeight.w300,
      );

  static TextStyle smallSize(BuildContext context, [Color? color]) => TextStyle(
        fontSize: _getSize(context).width * 0.03,
        fontWeight: FontWeight.w300,
        color: color ?? _getColorScheme(context).onBackground,
      );

  static ColorScheme _getColorScheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  static Size _getSize(BuildContext context) => MediaQuery.of(context).size;
}
