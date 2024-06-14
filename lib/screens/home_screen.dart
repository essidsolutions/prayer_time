import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prayer_times_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/prayer_tile.dart';
import 'prayer_detail_screen.dart';
import 'settings_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PrayerTimesProvider>(context, listen: false).fetchPrayerTimes();
  }

  String formatTime(String time, bool is24HourFormat) {
    final format = DateFormat("HH:mm");
    final dateTime = format.parse(time);
    if (is24HourFormat) {
      return format.format(dateTime);
    } else {
      return DateFormat.jm().format(dateTime);
    }
  }

  String calculateLastThird(String isha, String fajr) {
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
    return format.format(lastThirdStart);
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final prayerTimesProvider = Provider.of<PrayerTimesProvider>(context);
    final isDarkMode = settingsProvider.isDarkMode;
    final is24HourFormat = settingsProvider.is24HourFormat;
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Today\'s Prayer Times',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: bgColor,
              child: Consumer<PrayerTimesProvider>(
                builder: (context, provider, child) {
                  if (provider.prayerTimes.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final firstDayTimings = provider.prayerTimes[0];
                    final lastThird = calculateLastThird(
                        firstDayTimings['Isha'],
                        firstDayTimings['Fajr']
                    );

                    return ListView(
                      padding: EdgeInsets.all(10),
                      children: [
                        PrayerTile(
                          name: 'Fajr',
                          time: formatTime(firstDayTimings['Fajr'], is24HourFormat),
                          icon: Icons.brightness_5,
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
                          time: formatTime(firstDayTimings['Dhuhr'], is24HourFormat),
                          icon: Icons.brightness_6,
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
                          time: formatTime(firstDayTimings['Asr'], is24HourFormat),
                          icon: Icons.brightness_7,
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
                          time: formatTime(firstDayTimings['Maghrib'], is24HourFormat),
                          icon: Icons.brightness_4,
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
                          time: formatTime(firstDayTimings['Isha'], is24HourFormat),
                          icon: Icons.brightness_3,
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
                          time: formatTime(firstDayTimings['Imsak'], is24HourFormat),
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
                          time: formatTime(firstDayTimings['Midnight'], is24HourFormat),
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
                          time: formatTime(lastThird, is24HourFormat),
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
          ),
        ],
      ),
    );
  }
}
