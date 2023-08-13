import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../core/consts/app_typography.dart';
import '../../../../domain/entities/doctor.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key, required this.review}) : super(key: key);
  final Review review;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      title: Text(
        LocaleKeys.anonymous.tr(),
        style: AppTypography.semiBodySize(context),
      ),
      subtitle: Text(
        review.review,
        style: AppTypography.smallSize(context),
      ),
      contentPadding: EdgeInsets.zero,
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FittedBox(
              child: Text(
                '${review.rating}',
                style: AppTypography.smallSize(
                  context,
                  colorScheme.outline,
                ),
              ),
            ),
          ),
          const Expanded(
            child: FittedBox(
              child: Icon(
                Icons.star,
                color: Colors.yellow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
