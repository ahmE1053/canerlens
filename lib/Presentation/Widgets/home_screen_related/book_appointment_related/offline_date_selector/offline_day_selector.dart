import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../../core/consts/app_typography.dart';
import '../../../../../core/providers/book_appointment_provider.dart';
import '../../../../../core/utilities/appointment_selector_colors.dart';
import '../../../../../domain/entities/appointment.dart';
import '../../../../../domain/entities/doctor.dart';

class OfflineDaySelector extends ConsumerWidget {
  const OfflineDaySelector({
    Key? key,
    required this.day,
    required this.state,
    this.offlineDay,
  }) : super(key: key);
  final DateTime day;
  final OfflineAvailability? offlineDay;
  final TimeStates state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dayName = DateFormat.E(
      context.locale.languageCode,
    ).format(day);
    final colorMap = colors(Theme.of(context).colorScheme);

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
                  final formattedDay = '$day'.split(' ')[0];
                  final appointment = ref.read(bookAppointmentProvider);
                  final selectedDay = appointment.day;
                  if (selectedDay == formattedDay) {
                    ref.read(bookAppointmentProvider.notifier).copyWith(
                          appointment.copyWith(day: '', time: ''),
                        );
                    ref
                        .read(selectedOfflineDayTimes.notifier)
                        .update((state) => null);
                    return;
                  }
                  ref
                      .read(selectedOfflineDayTimes.notifier)
                      .update((state) => offlineDay);
                  ref.read(bookAppointmentProvider.notifier).copyWith(
                        appointment.copyWith(
                            day: formattedDay, time: offlineDay!.timeFrom),
                      );
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    dayName,
                    style: AppTypography.semiBodySize(
                      context,
                      colorMap[state]['text'],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    day.day.toString(),
                    style: AppTypography.semiBodySize(
                      context,
                      colorMap[state]['text'],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
