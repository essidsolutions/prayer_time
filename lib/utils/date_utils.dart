import 'package:intl/intl.dart';

String formatTime(String time, bool is24HourFormat) {
  final format = DateFormat("HH:mm");
  final dateTime = format.parse(time);
  if (is24HourFormat) {
    return format.format(dateTime);
  } else {
    return DateFormat.jm().format(dateTime);
  }
}

String calculateLastThird(String isha, String fajr) {
  final format = DateFormat("HH:mm");
  final ishaTime = format.parse(isha);
  final fajrTime = format.parse(fajr);

  Duration nightDuration;
  if (ishaTime.isBefore(fajrTime)) {
    nightDuration = fajrTime.difference(ishaTime);
  } else {
    final nextDayFajr = fajrTime.add(Duration(days: 1));
    nightDuration = nextDayFajr.difference(ishaTime);
  }

  final lastThirdDuration = nightDuration ~/ 3;
  final lastThirdStart = fajrTime.subtract(lastThirdDuration);
  return format.format(lastThirdStart);
}
