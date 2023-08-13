import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../../core/consts/app_typography.dart';
import '../../../../../core/providers/book_appointment_provider.dart';
import '../../../../../core/utilities/appointment_error_state.dart';
import '../../../../../domain/entities/appointment.dart';
import '../../../../../domain/entities/doctor.dart';
import 'online_day_selector.dart';
import 'time_selector_list.dart';

class OnlineBookingDateSelector extends ConsumerWidget {
  const OnlineBookingDateSelector({
    super.key,
    required this.mq,
    required this.errorState,
    required this.doctor,
    required this.colorScheme,
  });

  final Size mq;
  final Doctor doctor;
  final ColorScheme colorScheme;
  final AppointmentErrorState errorState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: mq.height * 0.07,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemExtent: mq.width * 0.15,
            itemBuilder: (context, index) {
              final selectedDay = ref.watch(bookAppointmentProvider).day;
              final day = DateTime.now().add(Duration(days: index));
              final dayInfoForBooking =
                  doctor.getDoctorAvailabilityForOnlineDay(day, selectedDay);
              final timeState = (errorState.day &&
                      dayInfoForBooking.timeState != TimeStates.disabled)
                  ? TimeStates.error
                  : dayInfoForBooking.timeState;
              return OnlineDaySelector(
                day: day,
                onlineDay: dayInfoForBooking.onlineAvailability,
                state: timeState,
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Text(
          LocaleKeys.time.tr(),
          style: AppTypography.bodySize(
            context,
            colorScheme.surfaceTint,
          ),
        ),
        const SizedBox(height: 16),
        TimeSelectorList(
          errorState: errorState.time,
        ),
      ],
    );
  }
}
