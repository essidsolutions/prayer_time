import 'package:flutter/material.dart';
import '../services/location_service.dart';
import '../services/prayer_time_service.dart';
import 'package:geolocator/geolocator.dart';

class PrayerTimesProvider with ChangeNotifier {
  Map<String, dynamic> _prayerTimes = {};
  Map<String, dynamic> get prayerTimes => _prayerTimes;

  final LocationService _locationService = LocationService();
  final PrayerTimeService _prayerTimeService = PrayerTimeService();

  Future<void> fetchPrayerTimes() async {
    try {
      Position position = await _locationService.getCurrentLocation();
      _prayerTimes = await _prayerTimeService.fetchPrayerTimes(position);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
