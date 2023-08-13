import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../../core/consts/app_typography.dart';
import '../../../../../core/providers/book_appointment_provider.dart';
import '../../../../../domain/entities/appointment.dart';
import 'time_selector.dart';

class TimeSelectorList extends HookConsumerWidget {
  const TimeSelectorList({Key? key, required this.errorState})
      : super(key: key);
  final bool errorState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTime = ref.watch(bookAppointmentProvider).time;
    final mq = MediaQuery.of(context).size;
    final list = ref.watch(selectedOnlineDayTimes);
    return SizedBox(
      height: mq.height * 0.1,
      child: list.isEmpty
          ? FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                LocaleKeys.selectADay.tr(),
                style: AppTypography.semiBodySize(context),
              ),
            )
          : GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: mq.width * 0.3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final dayTime = list[index];
                final available = dayTime.available;
                final timeState = (errorState && available)
                    ? TimeStates.error
                    : available
                        ? selectedTime == dayTime.timeOfDay
                            ? TimeStates.selected
                            : TimeStates.available
                        : TimeStates.disabled;
                return TimeSelector(
                  state: timeState,
                  time: DateTime.parse('2000-01-02 ${dayTime.timeOfDay}:00'),
                );
              },
            ),
    );
  }
}
