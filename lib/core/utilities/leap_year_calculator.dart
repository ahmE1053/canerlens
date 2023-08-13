import 'package:flutter/material.dart';

import '../consts/date_of_birth_consts.dart';

///Used to determine if february will be 28 or 29 days
///it modifies the notifiers directly
void leapYearCalculator(ValueNotifier<List<int?>> dateOfBirth,
    ValueNotifier<List<int>> daySelectionList) {
  final DOB = dateOfBirth.value;
  if (DOB[0] == null || DOB[1] == null) return;
  final year = DOB[0]!;
  final month = DOB[1]!;
  if (((year % 4 == 0 && year % 100 != 0) ||
          (year % 4 == 0 && year % 100 == 0 && year % 400 == 0)) &&
      month == 2) {
    daySelectionList.value = List.from(
      days.map((e) {
        //this modifies the number of days in the month not the last day of it
        if (e == 28) {
          return 29;
        } else {
          return e;
        }
      }),
    );
  }
}
