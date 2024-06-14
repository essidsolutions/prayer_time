import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../screens/prayer_detail_screen.dart';

class PrayerTimeService with ChangeNotifier {
  Future<List<Prayer>> getPrayerTimes(Position position) async {
    // Implement API call to fetch prayer times based on location
    final response = await http.get(Uri.parse('https://api.pray.zone/v2/times/today.json?longitude=${position.longitude}&latitude=${position.latitude}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final prayerTimes = (data['results']['datetime'][0]['times'] as Map<String, dynamic>).entries.map((entry) {
        return Prayer(name: entry.key, time: entry.value, rakaat: 2); // Example rakaat, update as needed
      }).toList();
      return prayerTimes;
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
}
