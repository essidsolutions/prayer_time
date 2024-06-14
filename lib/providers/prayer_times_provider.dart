import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/location_service.dart';
import '../services/prayer_time_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/prayer_time_model.dart';

class PrayerTimesProvider with ChangeNotifier {
  PrayerTimeModel? _prayerTimes;
  PrayerTimeModel? get prayerTimes => _prayerTimes;
  bool _isCachedData = false;
  bool get isCachedData => _isCachedData;
  String _location = '';
  String get location => _location;
  String _hijriDate = '';
  String get hijriDate => _hijriDate;

  final LocationService _locationService = LocationService();
  final PrayerTimeService _prayerTimeService = PrayerTimeService();

  Future<void> fetchPrayerTimes({DateTime? date}) async {
    try {
      Position position = await _locationService.getCurrentLocation();
      _location = await _locationService.getAddressFromCoordinates(position);
      final data = await _prayerTimeService.fetchPrayerTimes(position, date: date);
      _prayerTimes = PrayerTimeModel.fromJson(data['timings']);
      _hijriDate = data['hijriDate'];
      _isCachedData = false;
      await _loadCustomPrayers();
      notifyListeners();
    } catch (e) {
      print('Error fetching prayer times: $e');
      final cachedData = await _prayerTimeService.getCachedPrayerTimes();
      if (cachedData != null) {
        _prayerTimes = PrayerTimeModel.fromJson(cachedData['timings']);
        _hijriDate = cachedData['hijriDate'];
        _isCachedData = true;
        await _loadCustomPrayers();
        notifyListeners();
      } else {
        print('Error loading cached prayer times: $e');
      }
    }
  }

  Future<void> _loadCustomPrayers() async {
    final prefs = await SharedPreferences.getInstance();
    final customPrayersString = prefs.getString('customPrayers');
    if (customPrayersString != null) {
      final customPrayersJson = json.decode(customPrayersString) as List<dynamic>;
      final customPrayers = customPrayersJson.map((prayer) => Prayer.fromJson(prayer)).toList();
      _prayerTimes?.customPrayers = customPrayers;
    }
  }

  void addCustomPrayer(Prayer prayer) {
    _prayerTimes?.customPrayers.add(prayer);
    _saveCustomPrayers();
    notifyListeners();
  }

  void _saveCustomPrayers() async {
    if (_prayerTimes != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('customPrayers', json.encode(_prayerTimes!.customPrayers.map((prayer) => prayer.toJson()).toList()));
    }
  }
}
