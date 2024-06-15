// errors/prayer_time_errors.dart
class PrayerTimeError implements Exception {
  final String message;
  PrayerTimeError(this.message);

  @override
  String toString() => 'PrayerTimeError: $message';
}
