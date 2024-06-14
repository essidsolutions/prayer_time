import 'package:intl/intl.dart';

class Prayer {
  final String name;
  final String time;
  final String icon;
  final String description;
  final int rakaa;

  Prayer({
    required this.name,
    required this.time,
    required this.icon,
    required this.description,
    required this.rakaa,
  });

  factory Prayer.fromJson(Map<String, dynamic> json) {
    return Prayer(
      name: json['name'],
      time: json['time'],
      icon: json['icon'],
      description: json['description'],
      rakaa: json['rakaa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'time': time,
      'icon': icon,
      'description': description,
      'rakaa': rakaa,
    };
  }
}

class PrayerTimeModel {
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;
  String lastThird;
  List<Prayer> customPrayers;

  PrayerTimeModel({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    this.lastThird = 'N/A',
    this.customPrayers = const [],
  });

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    var prayerTimeModel = PrayerTimeModel(
      fajr: json['Fajr'] ?? 'Unknown',
      dhuhr: json['Dhuhr'] ?? 'Unknown',
      asr: json['Asr'] ?? 'Unknown',
      maghrib: json['Maghrib'] ?? 'Unknown',
      isha: json['Isha'] ?? 'Unknown',
      imsak: json['Imsak'] ?? 'Unknown',
      midnight: json['Midnight'] ?? 'Unknown',
      customPrayers: (json['customPrayers'] as List<dynamic>?)
          ?.map((prayer) => Prayer.fromJson(prayer))
          .toList() ??
          [],
    );

    prayerTimeModel.calculateLastThird();
    return prayerTimeModel;
  }

  Map<String, dynamic> toJson() {
    return {
      'Fajr': fajr,
      'Dhuhr': dhuhr,
      'Asr': asr,
      'Maghrib': maghrib,
      'Isha': isha,
      'Imsak': imsak,
      'Midnight': midnight,
      'LastThird': lastThird,
      'customPrayers': customPrayers.map((prayer) => prayer.toJson()).toList(),
    };
  }

  void calculateLastThird() {
    if (isha == 'Unknown' || fajr == 'Unknown') {
      lastThird = 'Unknown';
      return;
    }

    final format = DateFormat("HH:mm");
    final ishaTime = format.parse(isha);
    final fajrTime = format.parse(fajr);

    Duration nightDuration;
    if (ishaTime.isBefore(fajrTime)) {
      nightDuration = fajrTime.difference(ishaTime);
    } else {
      final nextDayFajr = fajrTime.add(Duration(days: 1));
      nightDuration = nextDayFajr.difference(ishaTime);
    }

    final lastThirdDuration = nightDuration ~/ 3;
    final lastThirdStart = fajrTime.subtract(lastThirdDuration);
    lastThird = format.format(lastThirdStart);
  }
}
