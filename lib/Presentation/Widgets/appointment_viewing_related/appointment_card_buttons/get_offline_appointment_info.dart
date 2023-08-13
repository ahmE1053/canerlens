import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

class GetOfflineAppointmentInfoButton extends ConsumerWidget {
  const GetOfflineAppointmentInfoButton({
    Key? key,
    required this.appointmentId,
  }) : super(key: key);
  final String appointmentId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
