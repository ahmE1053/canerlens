import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../Presentation/Widgets/appointment_viewing_related/appointment_card_buttons/appointment_offline_coming_buttons.dart';
import '../../Presentation/Widgets/appointment_viewing_related/appointment_card_buttons/appointment_online_coming_buttons.dart';
import '../../Presentation/Widgets/appointment_viewing_related/appointment_card_buttons/cancellation_reason_button.dart';
import '../../Presentation/Widgets/appointment_viewing_related/appointment_card_buttons/leave_review_button.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/doctor.dart';
import '24h_to_12h_converter.dart';

class AppointmentCardUtilities {
  final AppointmentState appointmentState;
  final AppointmentLocation appointmentLocation;
  const AppointmentCardUtilities(
      this.appointmentState, this.appointmentLocation);

  Color appointmentBorderCardColor(Color color) {
    final colorMap = {
      AppointmentState.done: Colors.green,
      AppointmentState.absent: Colors.red,
      AppointmentState.coming: color,
    };
    return colorMap[appointmentState]!;
  }

  String appointmentCardUpperText(String date) {
    final stringMap = {
      AppointmentState.done: LocaleKeys.appointmentDone.tr(),
      AppointmentState.absent: LocaleKeys.appointmentAbsent.tr(),
      AppointmentState.coming: '${LocaleKeys.appointmentComing.tr()} $date',
    };
    return stringMap[appointmentState]!;
  }

  String appointmentStateText(String time, String day) {
    final stringMap = {
      AppointmentState.coming: appointmentLocation ==
              AppointmentLocation.atClinic
          ? '${LocaleKeys.yourAppointmentIsAt.tr()} $day. ${LocaleKeys.pleaseGoFrom.tr()} ${time24to12Converter(time)}'
          : '${LocaleKeys.pleaseExpectACall.tr()} ${time24to12Converter(time)} - $day',
      //TODO: add the 'to' time if the appointment is offline.
      AppointmentState.done: '${LocaleKeys.appointmentSuccess.tr()} $day',
      AppointmentState.absent: LocaleKeys.appointmentAbsence.tr(),
    };
    return stringMap[appointmentState]!;
  }

  Widget appointmentCardButton(String appointmentId, Doctor doctor) {
    final widgetMap = {
      AppointmentState.coming:
          appointmentLocation == AppointmentLocation.atClinic
              ? AppointmentOfflineComingButtons(
                  appointmentId: appointmentId,
                  doctor: doctor,
                )
              : AppointmentOnlineComingButtons(
                  appointmentId: appointmentId,
                  doctor: doctor,
                ),
      AppointmentState.done: LeaveReviewButton(
        doctor: doctor,
        appointmentId: appointmentId,
      ),
      AppointmentState.absent: const CancellationReason(),
    };
    return widgetMap[appointmentState]!;
  }
}
