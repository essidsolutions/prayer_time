import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import '../models/prayer_model.dart';

class PrayerTimeService with ChangeNotifier {
  Future<List<Prayer>> getPrayerTimes(Position position) async {
    final response = await http.get(Uri.parse('https://api.aladhan.com/v1/timings?latitude=${position.latitude}&longitude=${position.longitude}&method=2'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final timings = data['data']['timings'];
      final prayerTimes = [
        Prayer(name: 'Fajr', time: timings['Fajr'], rakaat: 2),
        Prayer(name: 'Dhuhr', time: timings['Dhuhr'], rakaat: 4),
        Prayer(name: 'Asr', time: timings['Asr'], rakaat: 4),
        Prayer(name: 'Maghrib', time: timings['Maghrib'], rakaat: 3),
        Prayer(name: 'Isha', time: timings['Isha'], rakaat: 4),
      ];
      return prayerTimes;
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
}
