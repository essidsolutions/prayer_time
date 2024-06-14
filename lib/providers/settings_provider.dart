import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  bool _is24HourFormat = false;
  bool get is24HourFormat => _is24HourFormat;

  String _selectedFont = 'Roboto';
  String get selectedFont => _selectedFont;

  double _fontSize = 16.0;
  double get fontSize => _fontSize;

  bool _isBold = false;
  bool get isBold => _isBold;

  bool _isItalic = false;
  bool get isItalic => _isItalic;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void toggleTimeFormat() {
    _is24HourFormat = !_is24HourFormat;
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
}
