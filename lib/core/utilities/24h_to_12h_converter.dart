import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

String time24to12Converter(String time) {
  List<String> times = time.split(':');
  int hour = int.parse(times[0]);
  bool am = true;
  if (hour > 11) {
    am = false;
    if (hour != 12) {
      hour -= 12;
    }
  }
  if (hour == 0) {
    hour = 12;
  }
  return '$hour:${times[1]} ${am ? LocaleKeys.am.tr() : LocaleKeys.pm.tr()}';
}
