import 'dart:async';
import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/providers/language_provider.dart';
import '../../../data/data source/doctor_remote_data_source.dart';
import '../../../data/data source/patient_remote_date_source.dart';
import '../../../domain/entities/doctor.dart';
import '../../widgets/messages_screen_related/call_related/ongoing_call_bottom_row.dart';
import '../../widgets/messages_screen_related/call_related/ongoing_caller_info.dart';
import '../../../core/utilities/context_extensions.dart';
import '../../../core/utilities/widget_helper.dart';

@RoutePage()
class OngoingCallScreen extends HookConsumerWidget {
  const OngoingCallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    final callDuration = useState(Duration.zero);
    final callDurationStreamSub =
        useMemoized(() => callDurationStream(callDuration));
    useEffect(
      () {
        return () {
          callDurationStreamSub.cancel();
        };
      },
      const [],
    );
    return Scaffold(
      body: Builder(
        builder: (context) {
          final patient = ref.watch(patientRemoteDataSourceProvider).value!;

          if (patient.callState == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final doctor =
              ref.watch(doctorsNotifierProvider.notifier).getDoctorById(
                    patient.callState!.doctorId,
                  );

          return OngoingCallStackWidget(
            doctor: doctor,
            callDuration: callDuration,
          );
        },
      ),
    ).getDoctorAndPatientInfo(ref);
  }
}

class OngoingCallStackWidget extends HookWidget {
  const OngoingCallStackWidget({
    super.key,
    required this.doctor,
    required this.callDuration,
  });

  final Doctor doctor;
  final ValueNotifier<Duration> callDuration;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 700),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child:
              OngoingAudioCallStack(doctor: doctor, callDuration: callDuration),
        ),
        Positioned(
          bottom: 0,
          width: context.width,
          height: context.height * 0.12,
          child: const OngoingCallBottomRow(),
        ),
      ],
    );
  }
}

class OngoingAudioCallStack extends StatelessWidget {
  const OngoingAudioCallStack({
    super.key,
    required this.doctor,
    required this.callDuration,
  });

  final Doctor doctor;
  final ValueNotifier<Duration> callDuration;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: doctor.imageUrl,
            fit: BoxFit.fill,
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 10,
              sigmaX: 10,
            ),
            child: Container(
              color: Colors.black38,
            ),
          ),
        ),
        OngoingCallerInfoWidget(
          doctor: doctor,
          callDuration: callDuration.value,
        ),
      ],
    );
  }
}

StreamSubscription<int> callDurationStream(ValueNotifier<Duration> duration) {
  return Stream.periodic(
    const Duration(seconds: 1),
    (computationCount) => computationCount + 1,
  ).listen(
    (event) {
      duration.value = Duration(
        seconds: event,
      );
    },
  );
}
