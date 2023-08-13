import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../core/providers/book_appointment_provider.dart';
import '../../../../domain/entities/doctor.dart';
import '../online_time_changer_widget.dart';

class ChangeOnlineTimeButton extends ConsumerWidget {
  const ChangeOnlineTimeButton({
    Key? key,
    required this.doctor,
    required this.appointmentId,
  }) : super(key: key);
  final Doctor doctor;
  final String appointmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(bookAppointmentProvider.notifier).reset();
            });
            return ScaffoldMessenger(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: WillPopScope(
                  onWillPop: () async => false,
                  child: Dialog(
                    child: OnlineTimeChangerWidget(
                      doctor: doctor,
                      appointmentId: appointmentId,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Text(
        LocaleKeys.changeTime.tr(),
      ),
    );
  }
}
