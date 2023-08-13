import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../domain/entities/doctor.dart';
import 'cancel_appointment_button.dart';
import 'change_online_time_button.dart';

class AppointmentOnlineComingButtons extends ConsumerWidget {
  const AppointmentOnlineComingButtons({
    super.key,
    required this.appointmentId,
    required this.doctor,
  });
  final String appointmentId;
  final Doctor doctor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: CancelAppointmentButton(appointmentId: appointmentId),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ChangeOnlineTimeButton(
              doctor: doctor, appointmentId: appointmentId),
        ),
      ],
    );
  }
}
