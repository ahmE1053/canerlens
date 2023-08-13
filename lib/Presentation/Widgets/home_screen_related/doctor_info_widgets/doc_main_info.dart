import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../core/consts/app_typography.dart';
import '../../../../domain/entities/doctor.dart';
import 'doc_info_row.dart';

class DocMainInfo extends StatelessWidget {
  const DocMainInfo({
    super.key,
    required this.doctor,
    required this.colorScheme,
  });

  final Doctor doctor;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: size.maxWidth * 0.35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                color: const Color(0xfff4f3ef),
                child: CachedNetworkImage(
                  imageUrl: doctor.imageUrl,
                  fit: BoxFit.fill,
                  errorWidget: (_, __, ___) => Image.asset(
                    'assets/images/profile-pic.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: size.maxWidth * 0.1),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.maxHeight * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Dr. ${doctor.name}',
                      style: AppTypography.semiHeadlineSize(
                        context,
                        colorScheme.surfaceTint,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.maxHeight * 0.05,
                  ),
                  Text(
                    '${doctor.speciality} doctor',
                    style: AppTypography.semiBodySize(
                      context,
                      colorScheme.outline,
                    ),
                  ),
                  SizedBox(
                    height: size.maxHeight * 0.05,
                  ),
                  Expanded(
                    child: DocInfoRow(
                      doctor: doctor,
                      size: size,
                      colorScheme: colorScheme,
                      icon: Icons.star,
                      title: '${doctor.rating} ${LocaleKeys.outOf5.tr()}',
                      subTitle: LocaleKeys.rating.tr(),
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(
                    height: size.maxHeight * 0.1,
                  ),
                  Expanded(
                    child: DocInfoRow(
                      doctor: doctor,
                      size: size,
                      colorScheme: colorScheme,
                      icon: Icons.groups_sharp,
                      title: doctor.reviews.length.toString(),
                      subTitle: LocaleKeys.patients.tr(),
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
