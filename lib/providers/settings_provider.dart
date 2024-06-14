import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  String _selectedFont = 'Roboto';
  double _fontSize = 16.0;
  bool _isBold = false;
  bool _isItalic = false;
  bool _is24HourFormat = true; // New field for time format

  bool get isDarkMode => _isDarkMode;
  String get selectedFont => _selectedFont;
  double get fontSize => _fontSize;
  bool get isBold => _isBold;
  bool get isItalic => _isItalic;
  bool get is24HourFormat => _is24HourFormat; // Getter for time format

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setSelectedFont(String font) {
    _selectedFont = font;
    notifyListeners();
  }

  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }

  void toggleBold() {
    _isBold = !_isBold;
    notifyListeners();
  }

  void toggleItalic() {
    _isItalic = !_isItalic;
    notifyListeners();
  }

  void toggleTimeFormat() { // Method to toggle time format
    _is24HourFormat = !_is24HourFormat;
    notifyListeners();
  }
}
