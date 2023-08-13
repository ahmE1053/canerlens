import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:medapp4/core/router/app_router.dart';
import 'package:medapp4/core/utilities/context_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/consts/app_typography.dart';
import '../../../core/providers/book_appointment_provider.dart';
import '../../../core/providers/language_provider.dart';
import '../../../data/data source/doctor_remote_data_source.dart';
import '../../../domain/entities/lat_lng.dart';
import '../../widgets/home_screen_related/doctor_info_widgets/doc_info_appbar.dart';
import '../../widgets/home_screen_related/doctor_info_widgets/doc_main_info.dart';
import '../../widgets/home_screen_related/doctor_info_widgets/review_card.dart';
import '../../widgets/home_screen_related/doctor_info_widgets/google_map_widget.dart';

@RoutePage()
class DoctorInfoScreen extends HookConsumerWidget {
  const DoctorInfoScreen({
    Key? key,
    @PathParam('id') required this.id,
  }) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    final mq = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      // backgroundColor: const Color(0xfff6f6fa),
      body: ref.watch(doctorsNotifierProvider).when(
            data: (doctorInfo) {
              final doctor =
                  doctorInfo.where((doctorInfo) => doctorInfo.id == id).single;
              final doctorClinicPosition = LatLng(
                doctor.location.coordinates[0],
                doctor.location.coordinates[1],
              );
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: mq.width * 0.05,
                    horizontal: mq.width * 0.07,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DocInfoAppBar(
                        doctor: doctor,
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        height: mq.height * 0.2,
                        child: DocMainInfo(
                          doctor: doctor,
                          colorScheme: colorScheme,
                        ),
                      ),
                      SizedBox(height: mq.height * 0.04),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: EdgeInsets.only(
                            top: mq.height * 0.015,
                            bottom: mq.height * 0.02,
                            left: mq.width * 0.05,
                            right: mq.width * 0.05,
                          ),
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Text(
                                LocaleKeys.biography.tr(),
                                style: AppTypography.bodySize(
                                  context,
                                  colorScheme.surfaceTint,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: mq.height * 0.03,
                                  maxHeight: mq.height * 0.1,
                                ),
                                child: SingleChildScrollView(
                                  child: Text(
                                    doctor.aboutDoctor,
                                    style: AppTypography.semiBodySize(
                                      context,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                LocaleKeys.location.tr(),
                                style: AppTypography.bodySize(
                                  context,
                                  colorScheme.surfaceTint,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: mq.height * 0.15,
                                child: MyGoogleMapWidget(
                                  doctorClinicPosition: doctorClinicPosition,
                                  doctor: doctor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                LocaleKeys.reviews.tr(),
                                style: AppTypography.bodySize(
                                  context,
                                  colorScheme.surfaceTint,
                                ),
                              ),
                              ...doctor.reviews.map(
                                (e) => ReviewCard(
                                  review: e,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (error, stackTrace) => const Center(
              child: Text('An error occurred, please try again later'),
            ),
            loading: () => Center(
              child: SpinKitFadingGrid(color: context.primaryColor),
            ),
          ),
      bottomNavigationBar: SizedBox(
        height: mq.height * 0.12,
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.secondaryContainer,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        LocaleKeys.consultationPrice.tr(),
                        style: AppTypography.semiBodySize(
                          context,
                          colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '\$ 52',
                        style: AppTypography.bodySize(
                          context,
                          colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(bookAppointmentProvider.notifier).changeDoctor(id);
                    context.router.push(
                      BookAppointmentRoute(id: id),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      LocaleKeys.bookAppointment.tr(),
                      style: AppTypography.semiHeadlineSize(
                        context,
                        colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
