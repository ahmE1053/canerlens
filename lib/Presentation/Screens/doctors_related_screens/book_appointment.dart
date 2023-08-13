import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/consts/app_typography.dart';
import '../../../core/providers/book_appointment_provider.dart';
import '../../../core/providers/language_provider.dart';
import '../../../core/utilities/appointment_error_state.dart';
import '../../../data/data source/doctor_remote_data_source.dart';
import '../../widgets/authentication_handling_widgets/my_text_field_widget.dart';
import '../../widgets/home_screen_related/book_appointment_related/appointment_book_button.dart';
import '../../widgets/home_screen_related/book_appointment_related/appointment_location_transition_handler.dart';

@RoutePage()
class BookAppointmentScreen extends HookConsumerWidget {
  const BookAppointmentScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final additionalInfoController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final mq = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final errorState = useState(const AppointmentErrorState());
    final bottomButtonSize = useState(mq.height * 0.07);
    ref.watch(languageProvider);
    return WillPopScope(
      onWillPop: () async {
        ref.read(bookAppointmentProvider.notifier).reset();
        return true;
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: ref.watch(doctorsNotifierProvider).when(
              data: (doctorInfo) {
                final doctor = doctorInfo
                    .where((doctorInfo) => doctorInfo.id == id)
                    .single;
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      LocaleKeys.bookAppointment.tr(),
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView(
                      children: [
                        AppointmentLocationTransitionHandler(
                          appointmentErrorState: errorState.value,
                          doctor: doctor,
                          colorScheme: colorScheme,
                          mq: mq,
                          textInfo: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 8),
                                MyTextField(
                                  controller: phoneController,
                                  colorScheme: colorScheme,
                                  label: LocaleKeys.phoneNumber.tr(),
                                  suffix: const Icon(Icons.phone),
                                  validator: (value) {
                                    if (!value!.isPhoneValid()) {
                                      return LocaleKeys.wrongPhoneNumber.tr();
                                    }
                                    return null;
                                  },
                                  inputType: TextInputType.phone,
                                  formatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                                const SizedBox(height: 8),
                                MyTextField(
                                  controller: additionalInfoController,
                                  colorScheme: colorScheme,
                                  label: LocaleKeys.additionalInfo.tr(),
                                  maxLines: 3,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  LocaleKeys.day.tr(),
                                  style: AppTypography.bodySize(
                                    context,
                                    colorScheme.surfaceTint,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: AppointmentBookButton(
                    bottomButtonSize: bottomButtonSize,
                    doctor: doctor,
                    formKey: formKey,
                    errorState: errorState,
                    phoneController: phoneController,
                    additionalInfoController: additionalInfoController,
                    id: id,
                  ),
                );
              },
              error: (_, __) => const Center(
                child: Text('Error'),
              ),
              loading: () => Center(
                child: SpinKitDualRing(
                  color: colorScheme.primary,
                ),
              ),
            ),
      ),
    );
  }
}

enum TimeStates {
  selected,
  available,
  disabled,
  error,
}
