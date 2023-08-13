import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../core/providers/call_mic_speaker_providers.dart';
import '../../../../core/utilities/agora_rtc_engine.dart';
import '../../../../core/utilities/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../data/data source/doctor_remote_data_source.dart';
import '../../../../data/data source/patient_remote_date_source.dart';
import 'end_or_reject_call_button.dart';
import '../../../../core/utilities/widget_helper.dart';

class OngoingCallBottomRow extends ConsumerWidget {
  const OngoingCallBottomRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patient = ref.watch(patientRemoteDataSourceProvider).value!;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.all(16),
      padding: EdgeInsets.all(context.width * 0.01),
      decoration: BoxDecoration(
        color: context.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              ref.read(agoraEngineProvider.notifier).mute();
            },
            style: IconButton.styleFrom(
              shape: const CircleBorder(),
              foregroundColor: Colors.white,
            ),
            icon: Consumer(
              builder: (context, ref, _) {
                final muted = ref.watch(mutedProvider);
                return Icon(
                  muted ? Icons.mic : Icons.mic_off_outlined,
                  size: context.width * 0.07,
                ).wrapWithFittedBox;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: EndOrRejectCallButton(
              withMargin: false,
              onTap: () {
                ref
                    .read(doctorsNotifierProvider.notifier)
                    .endCall(patient.callState!.doctorId);
                ref.read(patientRemoteDataSourceProvider.notifier).endCall();
              },
            ),
          ),
          IconButton(
            onPressed: () async {
              await ref.read(agoraEngineProvider.notifier).speaker();
            },
            style: IconButton.styleFrom(
              shape: const CircleBorder(),
              foregroundColor: Colors.white,
            ),
            icon: Consumer(
              builder: (context, ref, _) {
                final speakerEnabled = ref.watch(speakerProvider);
                return Icon(
                  speakerEnabled ? Bootstrap.phone : Bootstrap.volume_up,
                  size: context.width * 0.07,
                ).wrapWithFittedBox;
              },
            ),
          ),
        ],
      ),
    );
  }
}
