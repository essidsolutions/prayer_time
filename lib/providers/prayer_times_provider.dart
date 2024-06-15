import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/prayer_time_model.dart';
import '../errors/location_errors.dart';
import '../errors/prayer_time_errors.dart';
import '../services/location_service.dart' as loc_service;
import '../services/prayer_time_service.dart' as pt_service;

class PrayerTimesProvider with ChangeNotifier {
  PrayerTimeModel? _prayerTimes;
  PrayerTimeModel? get prayerTimes => _prayerTimes;
  bool _isCachedData = false;
  bool get isCachedData => _isCachedData;
  String _location = '';
  String get location => _location;
  String _hijriDate = '';
  String get hijriDate => _hijriDate;

  final loc_service.LocationService _locationService = loc_service.LocationService();
  final pt_service.PrayerTimeService _prayerTimeService = pt_service.PrayerTimeService();

  Future<void> fetchPrayerTimes({DateTime? date}) async {
    try {
      Position position = await _locationService.getCurrentLocation();
      print('Current Position: ${position.latitude}, ${position.longitude}'); // Debugging info

      _location = await _locationService.getAddressFromCoordinates(position);
      print('Fetched Address: $_location'); // Debugging info

      final data = await _prayerTimeService.fetchPrayerTimes(position, date: date);
      _prayerTimes = PrayerTimeModel.fromJson(data['timings']);
      _hijriDate = data['hijriDate'];
      _isCachedData = false;
      await _loadCustomPrayers();
      notifyListeners();
    } on LocationError catch (e) {
      print('LocationError: ${e.message}');
      _location = 'Error: ${e.message}';
      notifyListeners();
    } on PrayerTimeError catch (e) {
      print('PrayerTimeError: ${e.message}');
      final cachedData = await _prayerTimeService.getCachedPrayerTimes();
      if (cachedData != null) {
        _prayerTimes = PrayerTimeModel.fromJson(cachedData['timings']);
        _hijriDate = cachedData['hijriDate'];
        _isCachedData = true;
        await _loadCustomPrayers();
        notifyListeners();
      } else {
        print('Error loading cached prayer times: ${e.message}');
      }
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  Future<void> _loadCustomPrayers() async {
    final prefs = await SharedPreferences.getInstance();
    final customPrayersString = prefs.getString('customPrayers');
    if (customPrayersString != null) {
      final customPrayersJson = json.decode(customPrayersString) as List<dynamic>;
      final customPrayers = customPrayersJson.map((prayer) => Prayer.fromJson(prayer)).toList();
      _prayerTimes?.customPrayers = customPrayers;
    } else {
      _prayerTimes?.customPrayers = [];
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
