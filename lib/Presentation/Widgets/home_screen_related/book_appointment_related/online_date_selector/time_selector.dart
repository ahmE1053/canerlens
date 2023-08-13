import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../../core/consts/app_typography.dart';
import '../../../../../core/providers/book_appointment_provider.dart';
import '../../../../../core/utilities/appointment_selector_colors.dart';
import '../../../../../domain/entities/appointment.dart';

class TimeSelector extends ConsumerWidget {
  const TimeSelector({
    Key? key,
    required this.state,
    required this.time,
  }) : super(key: key);
  final TimeStates state;
  final DateTime time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorMap = colors(Theme.of(context).colorScheme);
    final formatted12HourTime = DateFormat.jm(
      context.locale.languageCode,
    ).format(time);
    final formatted24HourTime = DateFormat.Hm(
      context.locale.languageCode,
    ).format(time);
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colorMap[state]['container'],
        border: Border.all(width: 2, color: colorMap[state]['border']),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: state == TimeStates.disabled
              ? null
              : () {
                  final currentSelectedTime =
                      ref.read(bookAppointmentProvider).time;

                  if (currentSelectedTime == formatted24HourTime) {
                    ref.read(bookAppointmentProvider.notifier).changeTime('');
                    return;
                  }
                  ref
                      .read(bookAppointmentProvider.notifier)
                      .changeTime(formatted24HourTime);
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                formatted12HourTime,
                style: AppTypography.semiBodySize(
                  context,
                  colorMap[state]['text'],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
