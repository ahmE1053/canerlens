import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../core/consts/app_typography.dart';
import '../../../../core/providers/book_appointment_provider.dart';
import '../../../../core/utilities/appointment_error_state.dart';
import '../../../../domain/entities/appointment.dart';
import '../../../../domain/entities/doctor.dart';
import 'offline_date_selector/offline_booking_date_selector.dart';
import 'online_date_selector/online_booking_date_selector.dart';

class AppointmentLocationTransitionHandler extends HookConsumerWidget {
  const AppointmentLocationTransitionHandler({
    Key? key,
    required this.textInfo,
    required this.doctor,
    required this.mq,
    required this.colorScheme,
    required this.appointmentErrorState,
  }) : super(key: key);
  final Widget textInfo;
  final AppointmentErrorState appointmentErrorState;
  final Doctor doctor;
  final ColorScheme colorScheme;
  final Size mq;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = useState(AppointmentLocation.atClinic);
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 500));
    final onlineTransitionAnimation =
        Tween<Offset>(begin: const Offset(1.5, 0), end: Offset.zero)
            .animate(animationController);
    final offlineTransitionAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(animationController);
    useEffect(() => null, [animationController]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          LocaleKeys.fillRemainingInfo.tr(),
          style: AppTypography.semiHeadlineSize(context),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                selectedTileColor: colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                title: Text(
                  LocaleKeys.atClinic.tr(),
                  style: AppTypography.semiBodySize(context),
                ),
                value: AppointmentLocation.atClinic,
                groupValue: location.value,
                onChanged: (value) {
                  final appointment = ref.read(bookAppointmentProvider);
                  animationController.reverse();
                  location.value = AppointmentLocation.atClinic;
                  ref.read(bookAppointmentProvider.notifier).copyWith(
                        appointment.copyWith(
                          time: '',
                          day: '',
                          appointmentLocation: value!,
                        ),
                      );
                  ref
                      .read(selectedOnlineDayTimes.notifier)
                      .update((state) => []);
                },
                selected: location.value == AppointmentLocation.atClinic,
              ),
            ),
            Expanded(
              child: RadioListTile(
                selectedTileColor: colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                title: Text(
                  LocaleKeys.online.tr(),
                  style: AppTypography.semiBodySize(context),
                ),
                value: AppointmentLocation.online,
                groupValue: location.value,
                onChanged: (value) {
                  final appointment = ref.read(bookAppointmentProvider);
                  animationController.forward();
                  location.value = AppointmentLocation.online;
                  ref.read(bookAppointmentProvider.notifier).copyWith(
                        appointment.copyWith(
                          time: '',
                          day: '',
                          appointmentLocation: value!,
                        ),
                      );
                  ref
                      .read(selectedOfflineDayTimes.notifier)
                      .update((state) => null);
                },
                selected: location.value == AppointmentLocation.online,
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        textInfo,
        const SizedBox(height: 16),
        Stack(
          children: [
            AnimatedBuilder(
              builder: (context, child) {
                return Opacity(
                  opacity: offlineTransitionAnimation.value,
                  child: child,
                );
              },
              animation: offlineTransitionAnimation,
              child: Builder(
                builder: (context) {
                  if (!doctor.availableOffline) {
                    return Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        LocaleKeys.doctorNotAvailable.tr(),
                        // 'Dr. ${doctor.name} does not currently have any available appointment '
                        // 'slots. Please check back later for updated availability.'
                        // ' We apologize for any inconvenience this may cause.',
                        style: AppTypography.semiBodySize(context),
                      ),
                    );
                  }
                  return OfflineBookingDateSelector(
                    errorState: appointmentErrorState,
                    mq: mq,
                    doctor: doctor,
                    colorScheme: colorScheme,
                  );
                },
              ),
            ),
            SlideTransition(
              position: onlineTransitionAnimation,
              child: Builder(
                builder: (context) {
                  if (!doctor.availableOnline) {
                    return Text(
                      LocaleKeys.doctorNotAvailable.tr(),
                      // 'Dr. ${doctor.name} does not currently have any available appointment slots.'
                      // 'Please check back later for updated availability. We apologize '
                      // 'for any inconvenience this may cause.',
                    );
                  }
                  return OnlineBookingDateSelector(
                    errorState: appointmentErrorState,
                    mq: mq,
                    doctor: doctor,
                    colorScheme: colorScheme,
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
