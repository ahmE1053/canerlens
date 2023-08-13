import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:medapp4/core/utilities/context_extensions.dart';

import '../../data/data source/doctor_remote_data_source.dart';
import '../../data/data source/patient_remote_date_source.dart';

extension WidgetHelper on Widget {
  Widget wrapWithFadeAndSlide(
    double value,
    BuildContext context, [
    bool moveToLeft = false,
  ]) {
    final offsetValue = context.width * 0.5 * (value - 1);
    return Transform.translate(
      offset: Offset(moveToLeft ? offsetValue : -offsetValue, 0),
      child: Opacity(
        opacity: value,
        child: this,
      ),
    );
  }

  Widget get wrapWithKeyboardRemover => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: this,
      );

  Widget get wrapWithFittedBox => FittedBox(
        child: this,
      );
  Widget wrapWithFittedBoxWithFit(BoxFit fit) => FittedBox(
        fit: fit,
        child: this,
      );
  Widget getDoctorAndPatientInfo(WidgetRef ref) =>
      ref.watch(patientRemoteDataSourceProvider).when(
            data: (data) {
              final patient = data;
              if (patient == null) {
                //TODO: here
                // ref.read(routerHandlerProvider.notifier).enterFromPath('/auth');
                return Container();
              }
              return ref.watch(doctorsNotifierProvider).when(
                    data: (data) {
                      return this;
                    },
                    error: (error, stackTrace) => const Center(
                      child: Text(
                        'an error Occurred, weird',
                      ),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
            },
            error: (error, stackTrace) => const Center(
              child: Text(
                'an error Occurred, weird',
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );

  Widget getPatientInfo(WidgetRef ref) =>
      ref.watch(patientRemoteDataSourceProvider).when(
            data: (data) {
              return this;
            },
            error: (error, stackTrace) => const Center(
              child: Text(
                'an error Occurred, weird',
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
}
