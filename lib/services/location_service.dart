import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService with ChangeNotifier {
  Position? _currentPosition;
  String _cityName = '';

  Position? get currentLocation => _currentPosition;
  String get cityName => _cityName;

  LocationService() {
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      // Implement logic to get city name from coordinates
      _cityName = 'Dummy City';
    } catch (e) {
      // Handle error
    }
    notifyListeners();
  }
}
