import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../data/data source/appointments_remote_data_source.dart';

class CancelAppointmentButton extends ConsumerWidget {
  const CancelAppointmentButton({
    super.key,
    required this.appointmentId,
  });

  final String appointmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) {
            bool loading = false;
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text(
                    LocaleKeys.cancelAppointmentAlert.tr(),
                  ),
                  actions: loading
                      ? [
                          SpinKitChasingDots(
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                        ]
                      : [
                          ElevatedButton(
                            onPressed: () async {
                              loading = true;
                              setState(
                                () {},
                              );
                              await ref
                                  .read(appointmentNotifierProvider.notifier)
                                  .cancelAppointment(appointmentId);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              LocaleKeys.yes.tr(),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              LocaleKeys.no.tr(),
                            ),
                          ),
                        ],
                );
              },
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      child: FittedBox(
        child: Text(
          LocaleKeys.cancel.tr(),
        ),
      ),
    );
  }
}
