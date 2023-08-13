import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../core/consts/app_typography.dart';
import '../../../../core/utilities/appointment_card_utilities.dart';
import '../../../../core/utilities/duration_converter.dart';
import '../../../../data/data source/doctor_remote_data_source.dart';
import '../../../../domain/entities/appointment.dart';

class OnlineAppointmentCard extends ConsumerWidget {
  const OnlineAppointmentCard({Key? key, required this.appointment})
      : super(key: key);
  final Appointment appointment;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final mq = MediaQuery.of(context).size;
    final appointmentInfo = AppointmentCardUtilities(
        appointment.appointmentState, appointment.appointmentLocation);
    final borderColor =
        appointmentInfo.appointmentBorderCardColor(colorScheme.primary);

    final doctor = ref
        .read(doctorsNotifierProvider.notifier)
        .getDoctorById(appointment.doctorId);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: borderColor,
          ),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Builder(
              builder: (context) {
                String text =
                    appointmentInfo.appointmentCardUpperText(appointment.day);
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    color: borderColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      text,
                      style: AppTypography.semiBodySize(
                        context,
                        borderColor != colorScheme.primary
                            ? Colors.white
                            : colorScheme.onPrimary,
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: mq.height * 0.1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: mq.width * 0.2,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: doctor.imageUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'Dr. ${doctor.name}',
                              style: AppTypography.bodySize(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    appointmentInfo.appointmentStateText(
                      appointment.time,
                      appointment.day,
                    ),
                    style: AppTypography.semiBodySize(context),
                  ),
                  const SizedBox(height: 8),
                  if (!(appointment.appointmentState !=
                      AppointmentState.coming))
                    Text(
                      '${LocaleKeys.timeLeft.tr()}${formatDurationForAppointment(appointment.timeLeft)}',
                      style: AppTypography.smallSize(context),
                    ),
                  const SizedBox(height: 8),
                  Builder(
                    builder: (context) {
                      if (appointment.didLeaveCancellationReason ||
                          appointment.didLeaveReview) {
                        return Container();
                      }
                      return appointmentInfo.appointmentCardButton(
                        appointment.id,
                        doctor,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
