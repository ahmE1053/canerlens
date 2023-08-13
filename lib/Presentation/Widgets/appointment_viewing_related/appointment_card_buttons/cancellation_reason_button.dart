import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../core/consts/app_typography.dart';
import '../../../../core/utilities/cancellation_reasons.dart';

class CancellationReason extends StatelessWidget {
  const CancellationReason({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: SizedBox(
                height: mq.height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          LocaleKeys.whyCancelled.tr(),
                          style: AppTypography.semiHeadlineSize(context),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView(
                          children: reasons
                              .map(
                                (e) => Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        e,
                                        style: AppTypography.bodySize(context),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Text(
        LocaleKeys.tellUsWhy.tr(),
      ),
    );
  }
}

//TODO: make a list in the doctor model that holds the cancellation reason of all their appointments
