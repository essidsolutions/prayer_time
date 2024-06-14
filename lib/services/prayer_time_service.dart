import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class PrayerTimeService {
  final String _baseUrl = 'http://api.aladhan.com/v1/timings';

  Future<Map<String, dynamic>> fetchPrayerTimes(Position position) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl?latitude=${position.latitude}&longitude=${position.longitude}&method=2'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['timings'];
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
}
