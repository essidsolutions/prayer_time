// errors/location_errors.dart
class LocationError implements Exception {
  final String message;
  LocationError(this.message);

  @override
  String toString() => 'LocationError: $message';
}
