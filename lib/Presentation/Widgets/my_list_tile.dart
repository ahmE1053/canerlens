import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../core/consts/app_typography.dart';

enum ListTilePlace {
  middle,
  last,
}

class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key,
    required this.tilePlace,
    required this.title,
    required this.subtitle,
    required this.tileColor,
    this.textColor,
    this.onTap,
  });

  final ListTilePlace tilePlace;
  final String title, subtitle;
  final void Function()? onTap;
  final middleBorderRadius = BorderRadius.zero;
  final lastBorderRadius = const BorderRadius.only(
    bottomRight: Radius.circular(25),
    bottomLeft: Radius.circular(25),
  );
  final Color? textColor;
  final Color tileColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        textColor: textColor,
        tileColor: tileColor,
        onTap: onTap,
        title: FittedBox(
          alignment: AlignmentDirectional.centerStart,
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: AppTypography.semiHeadlineSize(context),
          ),
        ),
        subtitle: FittedBox(
          alignment: AlignmentDirectional.centerStart,
          fit: BoxFit.scaleDown,
          child: Text(
            subtitle,
            style: AppTypography.bodySize(context),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: tilePlace == ListTilePlace.middle
              ? middleBorderRadius
              : lastBorderRadius,
        ),
      ),
    );
  }
}
