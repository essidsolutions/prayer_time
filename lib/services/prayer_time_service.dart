import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class PrayerTimeService {
  Future<List<Map<String, dynamic>>> fetchPrayerTimes(Position position) async {
    final response = await http.get(
      Uri.parse('https://api.aladhan.com/v1/timings?latitude=${position.latitude}&longitude=${position.longitude}&method=2'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final timings = data['data']['timings'];

      // Save timings to cache
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('prayerTimes', json.encode(timings));

      return [timings];
    } else {
      throw Exception('Failed to load prayer times');
    }
  }

  Future<List<Map<String, dynamic>>?> getCachedPrayerTimes() async {
    final prefs = await SharedPreferences.getInstance();
    final prayerTimesString = prefs.getString('prayerTimes');

    if (prayerTimesString != null) {
      final timings = json.decode(prayerTimesString) as Map<String, dynamic>;
      return [timings];
    } else {
      return null;
    }
  }
}
