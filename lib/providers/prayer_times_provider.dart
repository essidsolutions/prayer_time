import 'package:flutter/material.dart';
import '../services/location_service.dart';
import '../services/prayer_time_service.dart';
import 'package:geolocator/geolocator.dart';

class PrayerTimesProvider with ChangeNotifier {
  List<Map<String, dynamic>> _prayerTimes = [];
  List<Map<String, dynamic>> get prayerTimes => _prayerTimes;
  bool _isCachedData = false;
  bool get isCachedData => _isCachedData;
  String _location = '';
  String get location => _location;

  final LocationService _locationService = LocationService();
  final PrayerTimeService _prayerTimeService = PrayerTimeService();

  Future<void> fetchPrayerTimes() async {
    try {
      Position position = await _locationService.getCurrentLocation();
      _location = await _locationService.getAddressFromCoordinates(position);
      _prayerTimes = await _prayerTimeService.fetchPrayerTimes(position);
      _isCachedData = false;
      print('Fetched prayer times from API: $_prayerTimes');
      notifyListeners();
    } catch (e) {
      print('Error fetching prayer times: $e');
      final cachedTimes = await _prayerTimeService.getCachedPrayerTimes();
      if (cachedTimes != null) {
        _prayerTimes = cachedTimes;
        _isCachedData = true;
        print('Loaded cached prayer times: $_prayerTimes');
        notifyListeners();
      } else {
        print('No cached data available');
      }
    }
  }
}
