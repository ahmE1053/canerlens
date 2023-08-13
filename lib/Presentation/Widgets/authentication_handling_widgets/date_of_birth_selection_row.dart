import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/consts/date_of_birth_consts.dart';
import '../../../core/utilities/leap_year_calculator.dart';
import 'date_of_birth.dart';

class DateOfBirthSelectionRow extends StatelessWidget {
  const DateOfBirthSelectionRow({
    super.key,
    required this.dateOfBirthErrorStateList,
    required this.mq,
    required this.dateOfBirth,
    required this.daySelectionList,
  });

  final ValueNotifier<List<bool>> dateOfBirthErrorStateList;
  final Size mq;
  final ValueNotifier<List<int?>> dateOfBirth;
  final ValueNotifier<List<int>> daySelectionList;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DateOfBirthDropDown(
          errorState: dateOfBirthErrorStateList.value[0],
          disabled: false,
          mq: mq,
          onChanged: (value) {
            final oldDOB = dateOfBirth.value;
            daySelectionList.value = days;

            dateOfBirth.value = <int?>[
              value,
              oldDOB[1],
              oldDOB[2],
            ];
            leapYearCalculator(dateOfBirth, daySelectionList);
          },
          values: years.reversed.toList(),
          value: dateOfBirth.value[0],
          hint: LocaleKeys.year.tr(),
        ),
        DateOfBirthDropDown(
          errorState: dateOfBirthErrorStateList.value[1],
          disabled: dateOfBirth.value[0] == null,
          mq: mq,
          value: dateOfBirth.value[1],
          onChanged: (value) {
            daySelectionList.value = days;
            dateOfBirth.value = [
              dateOfBirth.value[0],
              value,
              dateOfBirth.value[2],
            ];
            leapYearCalculator(dateOfBirth, daySelectionList);
          },
          values: months,
          hint: LocaleKeys.month.tr(),
        ),
        DateOfBirthDropDown(
          errorState: dateOfBirthErrorStateList.value[2],
          disabled: dateOfBirth.value[1] == null,
          mq: mq,
          value: dateOfBirth.value[2],
          onChanged: (value) {
            dateOfBirth.value = [
              dateOfBirth.value[0],
              dateOfBirth.value[1],
              value,
            ];
          },
          values: dateOfBirth.value[1] != null
              ? List.generate(
                  (daySelectionList.value[dateOfBirth.value[1]! - 1]),
                  (index) => index + 1)
              : [],
          hint: LocaleKeys.day.tr(),
        ),
      ],
    );
  }
}
