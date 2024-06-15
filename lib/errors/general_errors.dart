// errors/general_errors.dart
class GeneralError implements Exception {
  final String message;
  GeneralError(this.message);

  @override
  String toString() => 'GeneralError: $message';
}
