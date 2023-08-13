import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

String formatDurationForAppointment(Duration duration) {
  int days = duration.inDays;
  int hours = duration.inHours.remainder(24);
  int minutes = duration.inMinutes.remainder(60);
  String formattedTime = '';
  if (days > 0) {
    formattedTime =
        '$days ${days == 1 ? LocaleKeys.day.tr() : LocaleKeys.days.tr()} ';
    return formattedTime;
  }
  if (hours > 0) {
    formattedTime =
        '$hours ${hours == 1 ? LocaleKeys.hour.tr() : LocaleKeys.hours.tr()} ';
    return formattedTime;
  }
  if (minutes > 0) {
    formattedTime +=
        '$minutes ${minutes == 1 ? LocaleKeys.minute.tr() : LocaleKeys.minutes.tr()} ';
    return formattedTime;
  }

  return LocaleKeys.now.tr();
}

String formatDurationForSeekBar(Duration duration) {
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);
  String formattedTime = '';

  if (minutes > 0) {
    formattedTime = '${minutes >= 10 ? minutes : '0$minutes'}:';
  } else {
    formattedTime = '00:';
  }
  if (seconds > 0) {
    formattedTime += '${seconds >= 10 ? seconds : '0$seconds'}';
  } else {
    formattedTime += '00';
  }

  return formattedTime;
}

String formatDurationForCall(Duration duration) {
  int hours = duration.inHours.remainder(60);
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);
  String formattedTime = '';

  if (hours > 0) {
    formattedTime = '${hours >= 10 ? hours : '0$hours'}:';
  }
  if (minutes > 0) {
    formattedTime += '${minutes >= 10 ? minutes : '0$minutes'}:';
  } else {
    formattedTime += '00:';
  }
  if (seconds > 0) {
    formattedTime += '${seconds >= 10 ? seconds : '0$seconds'}';
  } else {
    formattedTime += '00';
  }

  return formattedTime;
}
