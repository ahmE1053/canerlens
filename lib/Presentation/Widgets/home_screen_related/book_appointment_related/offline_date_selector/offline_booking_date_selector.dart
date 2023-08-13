import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../../core/providers/book_appointment_provider.dart';
import '../../../../../core/utilities/appointment_error_state.dart';
import '../../../../../domain/entities/appointment.dart';
import '../../../../../domain/entities/doctor.dart';
import 'clinic_hours_viewer.dart';
import 'offline_day_selector.dart';

class OfflineBookingDateSelector extends ConsumerWidget {
  const OfflineBookingDateSelector({
    Key? key,
    required this.mq,
    required this.doctor,
    required this.colorScheme,
    required this.errorState,
  }) : super(key: key);
  final Size mq;
  final AppointmentErrorState errorState;
  final Doctor doctor;
  final ColorScheme colorScheme;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
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
                  doctor.getDoctorAvailabilityForOfflineDay(day, selectedDay);
              final timeState = (errorState.day &&
                      dayInfoForBooking.timeState != TimeStates.disabled)
                  ? TimeStates.error
                  : dayInfoForBooking.timeState;
              return OfflineDaySelector(
                day: day,
                offlineDay: dayInfoForBooking.offlineAvailability,
                state: timeState,
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        ClinicHoursViewer(colorScheme)
      ],
    );
  }
}
