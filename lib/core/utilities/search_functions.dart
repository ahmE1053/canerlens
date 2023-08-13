import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data source/doctor_remote_data_source.dart';
import '../../domain/entities/doctor.dart';
import '../../domain/entities/specialties.dart';
import '../providers/state_providers.dart';
import 'specialties_map.dart';

void searchForSpecialties(
    WidgetRef ref, TextEditingController searchController) {
  final results = <MedicalSpecialties>[];
  final searchText = searchController.value.text.toLowerCase();

  for (var medicalEntry in specialties) {
    if (medicalEntry.simpleName.contains(searchText) ||
        medicalEntry.complexName.contains(searchText)) {
      results.add(medicalEntry);
    }
  }
  ref.read(specialtiesSearchResults.notifier).update((state) => results);
}

//this uses a binary search with big o(log(n)+m)
void searchForDoctors(WidgetRef ref, TextEditingController searchController) {
  final results = <Doctor>[];
  final searchText = searchController.value.text.toLowerCase();
  final doctorsList = ref.read(doctorsNotifierProvider).value!
    ..sort(
      (a, b) => a.name.compareTo(b.name),
    );

  for (var doctor in doctorsList) {
    if (doctor.name.toLowerCase().contains(searchText)) {
      results.add(doctor);
    }
  }

  ref.read(doctorSearchResults.notifier).update((state) => results);
}

// /*
// * a pointer for the start of the list, end of it and the location of the first matched index
// * this is used with the last matched index which is defined down below
// * to iterates through the items in between which may contain the search text in any part of the name
// */

// int low = 0, high = doctorsList.length - 1, firstMatchedIndex = -1;

// while (low <= high) {
//   /*
//   * creates a pointer to the middle of the list and in subsequent loop the middle of the
//   * low and high indexes then checks if the mid points to a text that contains the search text
//   * if it does it points to firstMatchedIndex to it and starts again to see if there was an earlier
//   * match
//   */
//   int mid = (low + high) ~/ 2;

//   bool contains = doctorsList[mid].name.toLowerCase().contains(searchText);
//   if (contains) {
//     firstMatchedIndex = mid;
//     high = mid - 1;
//   } else {
//     /*
//     * the positive comparison value indicates that the doctor name is after the
//     * search text then we need to move the high pointer before the mid and try again
//     * if not then the low will be after the mid
//     * */
//     int comparison =
//         doctorsList[mid].name.toLowerCase().compareTo(searchText);
//     if (comparison > 0) {
//       high = mid - 1;
//     } else {
//       low = mid + 1;
//     }
//   }
// }

// //no matches found
// if (firstMatchedIndex == -1) {
//   ref.read(doctorSearchResults.notifier).update((state) => results);
//   return;
// }
// /*
// * if there was a match found then the firstMatchedIndex has to be the first
// * in the list we do the same thing but this time use it to determine the lastMatchedIndex
// * */
// low = 0;
// high = doctorsList.length - 1;
// int lastMatchedIndex = -1;

// while (low <= high) {
//   int mid = (low + high) ~/ 2;
//   bool contains = doctorsList[mid].name.toLowerCase().contains(searchText);
//   if (contains) {
//     lastMatchedIndex = mid;
//     low = mid + 1;
//   } else {
//     int comparison =
//         doctorsList[mid].name.toLowerCase().compareTo(searchText);
//     if (comparison > 0) {
//       high = mid - 1;
//     } else {
//       low = mid + 1;
//     }
//   }
// }
// if (firstMatchedIndex == lastMatchedIndex) {
//   results.add(doctorsList[firstMatchedIndex]);
//   ref.read(doctorSearchResults.notifier).update((state) => results);
//   return;
// }

// /*
// * check the values between the first and last index and add the values the contain the search text
// * */
// for (int i = firstMatchedIndex;
//     i <= min(lastMatchedIndex, lastMatchedIndex + 10);
//     i++) {
//   if (doctorsList[i].name.toLowerCase().contains(searchText)) {
//     results.add(doctorsList[i]);
//   }
// }

// /*
// * sorts the list to make the names that start with the name first
// * */
// results.sort(
//   (a, b) => a.name.toLowerCase().compareTo(searchText),
// );
