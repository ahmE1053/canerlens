import 'package:auto_route/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/providers/language_provider.dart';
import '../../../data/data source/doctor_remote_data_source.dart';
import '../../../data/data source/patient_remote_date_source.dart';
import '../../widgets/home_screen_related/normal_doctor_card.dart';
import '../../widgets/home_screen_related/not_found.dart';

@RoutePage()
class FavoriteDoctorsScreen extends HookConsumerWidget {
  const FavoriteDoctorsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    final listKey = useMemoized(() => GlobalKey<AnimatedListState>());
    final patient = ref.watch(patientRemoteDataSourceProvider).value!;
    final favoriteDoctorsList = patient.favoriteDoctors;
    final doctors = ref
        .read(doctorsNotifierProvider.notifier)
        .getFavoriteDoctors(favoriteDoctorsList);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.favoriteDoctors.tr(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: favoriteDoctorsList.isEmpty
            ? NotFound(
                text: LocaleKeys.noFavoritesYet.tr(),
              )
            : AnimatedList(
                key: listKey,
                initialItemCount: favoriteDoctorsList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index, animation) {
                  return NormalDoctorCard(
                    doctor: doctors[index],
                    isFav: true,
                    colorScheme: Theme.of(context).colorScheme,
                    lastItem: favoriteDoctorsList.length == 1,
                    screenRef: favoriteDoctorsList.length == 1 ? ref : null,
                    additionalFunction: () {
                      listKey.currentState!.removeItem(
                        duration: const Duration(milliseconds: 500),
                        index,
                        (context, animation) => SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.vertical,
                          child: NormalDoctorCard(
                            doctor: doctors[index],
                            isFav: false,
                            colorScheme: Theme.of(context).colorScheme,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
