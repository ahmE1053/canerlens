import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../data/data source/patient_remote_date_source.dart';
import '../../../../domain/entities/doctor.dart';
import 'doc_info_icon_button.dart';

class DocInfoAppBar extends StatelessWidget {
  const DocInfoAppBar({
    super.key,
    required this.doctor,
    required this.colorScheme,
  });

  final Doctor doctor;
  final ColorScheme colorScheme;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DocInfoIconButton(
          onTap: () {
            context.router.pop();
          },
          color: colorScheme.onPrimaryContainer,
          icon: Icons.arrow_back,
        ),
        Consumer(
          builder: (context, ref, child) {
            final isFav = ref
                .watch(patientRemoteDataSourceProvider)
                .value!
                .favoriteDoctors
                .contains(
                  doctor.id,
                );
            return DocInfoIconButton(
              color: colorScheme.outline,
              onTap: () {
                ref
                    .read(
                      patientRemoteDataSourceProvider.notifier,
                    )
                    .handleFavorite(
                      doctor.id,
                    );
              },
              icon: isFav ? Icons.favorite : Icons.favorite_border,
            );
          },
        ),
      ],
    );
  }
}
