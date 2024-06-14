import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prayer_times_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/prayer_tile.dart';
import 'prayer_detail_screen.dart';
import 'settings_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PrayerTimesProvider>(context, listen: false).fetchPrayerTimes();
  }

  String calculateLastThird(String isha, String fajr) {
    final format = DateFormat("HH:mm");
    final ishaTime = format.parse(isha);
    final fajrTime = format.parse(fajr);

    Duration nightDuration;
    if (ishaTime.isBefore(fajrTime)) {
      nightDuration = fajrTime.difference(ishaTime);
    } else {
      final midnight = DateTime(ishaTime.year, ishaTime.month, ishaTime.day, 23, 59);
      final nextDayFajr = fajrTime.add(Duration(days: 1));
      nightDuration = nextDayFajr.difference(ishaTime);
    }

    final lastThirdDuration = nightDuration ~/ 3;
    final lastThirdStart = fajrTime.subtract(lastThirdDuration);
    return format.format(lastThirdStart);
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final isDarkMode = settingsProvider.isDarkMode;
    final bgColor = isDarkMode ? Colors.black : Colors.white;
    final borderColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Times'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: bgColor,
        child: Consumer<PrayerTimesProvider>(
          builder: (context, provider, child) {
            if (provider.prayerTimes.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              final lastThird = calculateLastThird(
                  provider.prayerTimes['Isha'],
                  provider.prayerTimes['Fajr']
              );

              return ListView(
                padding: EdgeInsets.all(10),
                children: [
                  PrayerTile(
                    name: 'Fajr',
                    time: provider.prayerTimes['Fajr'],
                    icon: Icons.wb_twighlight,
                    iconColor: Colors.blue,
                    borderColor: borderColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrayerDetailScreen(prayerName: 'Fajr'),
                        ),
                      );
                    },
                  ),
                  PrayerTile(
                    name: 'Dhuhr',
                    time: provider.prayerTimes['Dhuhr'],
                    icon: Icons.wb_sunny,
                    iconColor: Colors.orange,
                    borderColor: borderColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrayerDetailScreen(prayerName: 'Dhuhr'),
                        ),
                      );
                    },
                  ),
                  PrayerTile(
                    name: 'Asr',
                    time: provider.prayerTimes['Asr'],
                    icon: Icons.wb_sunny,
                    iconColor: Colors.deepOrange,
                    borderColor: borderColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrayerDetailScreen(prayerName: 'Asr'),
                        ),
                      );
                    },
                  ),
                  PrayerTile(
                    name: 'Maghrib',
                    time: provider.prayerTimes['Maghrib'],
                    icon: Icons.wb_twilight,
                    iconColor: Colors.redAccent,
                    borderColor: borderColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrayerDetailScreen(prayerName: 'Maghrib'),
                        ),
                      );
                    },
                  ),
                  PrayerTile(
                    name: 'Isha',
                    time: provider.prayerTimes['Isha'],
                    icon: Icons.night_shelter,
                    iconColor: Colors.indigo,
                    borderColor: borderColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrayerDetailScreen(prayerName: 'Isha'),
                        ),
                      );
                    },
                  ),
                  PrayerTile(
                    name: 'Chaffaa',
                    time: 'Add time here',
                    icon: Icons.nightlight_round,
                    iconColor: Colors.purple,
                    borderColor: borderColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrayerDetailScreen(prayerName: 'Chaffaa'),
                        ),
                      );
                    },
                  ),
                  PrayerTile(
                    name: 'Watr',
                    time: 'Add time here',
                    icon: Icons.nightlight_round,
                    iconColor: Colors.purpleAccent,
                    borderColor: borderColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrayerDetailScreen(prayerName: 'Watr'),
                        ),
                      );
                    },
                  ),
                  PrayerTile(
                    name: 'Imsak',
                    time: provider.prayerTimes['Imsak'],
                    icon: Icons.access_time,
                    iconColor: Colors.teal,
                    borderColor: borderColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrayerDetailScreen(prayerName: 'Imsak'),
                        ),
                      );
                    },
                  ),
                  PrayerTile(
                    name: 'Midnight',
                    time: provider.prayerTimes['Midnight'],
                    icon: Icons.access_time,
                    iconColor: Colors.cyan,
                    borderColor: borderColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrayerDetailScreen(prayerName: 'Midnight'),
                        ),
                      );
                    },
                  ),
                  PrayerTile(
                    name: 'Last Third',
                    time: lastThird,
                    icon: Icons.access_time,
                    iconColor: Colors.deepPurple,
                    borderColor: borderColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrayerDetailScreen(prayerName: 'Last Third'),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
