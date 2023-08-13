import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/providers/language_provider.dart';
import '../../../core/utilities/appointments_button_colors.dart';
import '../../../data/data source/appointments_remote_data_source.dart';
import '../../../domain/entities/appointment.dart';
import '../../widgets/appointment_viewing_related/appointment_cards/offline_appointment_card.dart';
import '../../widgets/appointment_viewing_related/appointment_cards/online_appointment_card.dart';
import '../../widgets/home_screen_related/not_found.dart';
import '../../../core/utilities/widget_helper.dart';

@RoutePage()
class AppointmentsScreen extends HookConsumerWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final onlineButtonState = useState(ButtonState.unpressed);
    final offlineButtonState = useState(ButtonState.unpressed);
    final onlineButtonColorMap =
        appointmentButtonColor(colorScheme, onlineButtonState.value);
    final offlineButtonColorMap =
        appointmentButtonColor(colorScheme, offlineButtonState.value);
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 250));
    final opacity = useAnimation(
        Tween<double>(begin: 1.0, end: 0.0).animate(animationController));
    final mq = MediaQuery.of(context).size;
    useEffect(
      () {
        animationController.addStatusListener(
          (status) {
            if (status == AnimationStatus.completed) {
              animationController.reverse();
            }
          },
        );
        return () {
          animationController.removeStatusListener(
            (_) {},
          );
        };
      },
      const [],
    );
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          LocaleKeys.yourAppointments.tr(),
        ),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, mq.height * 0.04),
          child: Row(
            children: [
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  onButtonTap(
                    onlineButtonState,
                    offlineButtonState,
                    animationController,
                    ref
                        .read(appointmentNotifierProvider.notifier)
                        .filterOffline,
                    ref
                        .read(appointmentNotifierProvider.notifier)
                        .returnToNormal,
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: onlineButtonColorMap['onBackground'],
                  backgroundColor: onlineButtonColorMap['background'],
                ),
                child: Text(
                  LocaleKeys.online.tr(),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  onButtonTap(
                    offlineButtonState,
                    onlineButtonState,
                    animationController,
                    ref.read(appointmentNotifierProvider.notifier).filterOnline,
                    ref
                        .read(appointmentNotifierProvider.notifier)
                        .returnToNormal,
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: offlineButtonColorMap['onBackground'],
                  backgroundColor: offlineButtonColorMap['background'],
                ),
                child: Text(
                  LocaleKeys.offline.tr(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ref.watch(appointmentNotifierProvider).when(
              data: (appointments) {
                if (appointments.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NotFound(
                        text: LocaleKeys.noAppointments.tr(),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          AutoTabsRouter.of(context).setActiveIndex(1);
                        },
                        child: Text(
                          LocaleKeys.goHome.tr(),
                        ),
                      ),
                    ],
                  );
                }
                return AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: opacity,
                      child: child,
                    );
                  },
                  child: ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final appointment = appointments[index];
                      if (appointment.appointmentLocation ==
                          AppointmentLocation.online) {
                        return OnlineAppointmentCard(
                          appointment: appointments[index],
                        );
                      }
                      return OfflineAppointmentCard(
                        appointment: appointment,
                      );
                    },
                  ),
                );
              },
              error: (_, __) {
                return const Center(
                  child: Text(
                    'An error Occurred. Weird\n Please try again later.',
                    textAlign: TextAlign.center,
                  ),
                );
              },
              loading: () => Center(
                child: SpinKitChasingDots(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
      ),
    ).getDoctorAndPatientInfo(ref);
  }
}

enum WhatKindToView {
  all,
  online,
  atClinic,
}
