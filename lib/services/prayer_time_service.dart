import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import '../errors/prayer_time_errors.dart';
import '../models/prayer_time_model.dart';

class PrayerTimeService {
  Future<Map<String, dynamic>> fetchPrayerTimes(Position position, {DateTime? date}) async {
    final dateString = date != null ? '&date=${date.toIso8601String().split('T')[0]}' : '';
    try {
      final response = await http.get(
        Uri.parse('https://api.aladhan.com/v1/timings?latitude=${position.latitude}&longitude=${position.longitude}&method=2$dateString'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final timings = data['data']['timings'];
        final hijriDate = data['data']['date']['hijri']['date'];

        // Save timings and date to cache
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('prayerTimes', json.encode(timings));
        await prefs.setString('prayerTimesHijriDate', hijriDate); // Save the Hijri date as well

        return {
          'timings': timings,
          'hijriDate': hijriDate,
        };
      } else {
        throw PrayerTimeError('Failed to load prayer times');
      }
    } catch (e) {
      throw PrayerTimeError('Error fetching prayer times: $e');
    }
  }

  Future<Map<String, dynamic>?> getCachedPrayerTimes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final prayerTimesString = prefs.getString('prayerTimes');
      final hijriDateString = prefs.getString('prayerTimesHijriDate');

      if (prayerTimesString != null && hijriDateString != null) {
        final timings = json.decode(prayerTimesString) as Map<String, dynamic>?;
        return {
          'timings': timings ?? {},
          'hijriDate': hijriDateString,
        };
      } else {
        return null;
      }
    } catch (e) {
      throw PrayerTimeError('Error loading cached prayer times: $e');
    }
  }
}
