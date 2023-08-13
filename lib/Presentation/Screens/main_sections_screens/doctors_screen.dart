import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/providers/language_provider.dart';
import '../../../core/providers/state_providers.dart';
import '../../../core/utilities/search_functions.dart';
import '../../../data/data source/doctor_remote_data_source.dart';
import '../../../data/data source/patient_remote_date_source.dart';
import '../../widgets/home_screen_related/normal_doctor_card.dart';
import '../../widgets/search_text_field.dart';
import '../../../core/utilities/widget_helper.dart';
import '../../../Presentation/Widgets/home_screen_related/not_found.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utilities/context_extensions.dart';

@RoutePage()
class DoctorsScreen extends HookConsumerWidget {
  const DoctorsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    final searchController = useTextEditingController();
    final results = ref.watch(doctorSearchResults);
    final didSearch = useState(false);
    final colorScheme = Theme.of(context).colorScheme;
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          ref.invalidate(homeSearchTextField);
          ref.invalidate(doctorSearchResults);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.doctorNavBar.tr(),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.pushRoute(
                    const FavoriteDoctorsRoute(),
                  );
                },
                icon: Icon(
                  Icons.favorite,
                  color: context.primaryColor,
                ),
              )
            ],
          ),
          body: Builder(builder: (context) {
            final patient = ref.watch(patientRemoteDataSourceProvider).value!;
            final doctorsList = ref.watch(doctorsNotifierProvider).value!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SearchTextField(
                    controller: searchController,
                    colorScheme: colorScheme,
                    searchFunction: () {
                      didSearch.value = true;
                      searchForDoctors(ref, searchController);
                    },
                    ref: ref,
                    formKey: formKey,
                    provider: homeSearchTextField,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: didSearch.value && results.isEmpty
                        ? NotFound(
                            text: LocaleKeys.noSearchResults.tr(),
                          )
                        : ListView.builder(
                            itemCount: results.isEmpty
                                ? doctorsList.length
                                : results.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final doctor = results.isEmpty
                                  ? doctorsList[index]
                                  : results[index];
                              final isFav = patient.favoriteDoctors.contains(
                                doctor.id,
                              );
                              return NormalDoctorCard(
                                doctor: doctor,
                                isFav: isFav,
                                colorScheme: colorScheme,
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          }).getDoctorAndPatientInfo(ref),
        ),
      ),
    );
  }
}
