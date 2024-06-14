import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService with ChangeNotifier {
  Position? _currentPosition;
  String _cityName = '';

  Position get currentLocation => _currentPosition!;
  String get cityName => _cityName;

  Future<void> getCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _cityName = 'Dummy City'; // Implement logic to get city name from coordinates
    notifyListeners();
  }
}
