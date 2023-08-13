import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utilities/context_extensions.dart';
import '../../../../data/data source/doctor_remote_data_source.dart';
import '../../../../data/data source/patient_remote_date_source.dart';
import 'end_or_reject_call_button.dart';

class IncomingCallResponseRowWidget extends ConsumerWidget {
  const IncomingCallResponseRowWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      height: context.height * 0.12,
      width: context.width,
      top: context.height * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          EndOrRejectCallButton(
            withMargin: true,
            onTap: () {
              final patient = ref.read(patientRemoteDataSourceProvider).value!;
              ref
                  .read(doctorsNotifierProvider.notifier)
                  .endCall(patient.callState!.doctorId);
              ref.read(patientRemoteDataSourceProvider.notifier).endCall();
            },
          ),
          const SizedBox.shrink(),
          GestureDetector(
            onTap: () {
              final patient = ref.read(patientRemoteDataSourceProvider).value!;
              ref
                  .read(doctorsNotifierProvider.notifier)
                  .answerCall(patient.callState!.doctorId);
              ref.read(patientRemoteDataSourceProvider.notifier).answerCall();
            },
            child: LottieBuilder.asset(
              'assets/lottie/incoming_call.json',
            ),
          ),
        ],
      ),
    );
  }
}
