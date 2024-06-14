import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

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
      await _getCityNameFromCoordinates(_currentPosition!);
    } catch (e) {
      // Handle error
    }
    notifyListeners();
  }

  Future<void> _getCityNameFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      _cityName = place.locality ?? 'Unknown city';
    } catch (e) {
      _cityName = 'Unknown city';
    }
    notifyListeners();
  }
}
