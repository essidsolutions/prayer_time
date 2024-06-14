import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prayer_times_provider.dart';
import '../widgets/prayer_tile.dart';
import 'prayer_detail_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prayer Times',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: Colors.white,
        child: Consumer<PrayerTimesProvider>(
          builder: (context, provider, child) {
            if (provider.prayerTimes.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                padding: EdgeInsets.all(10),
                children: [
                  PrayerTile(
                    name: 'Fajr',
                    time: provider.prayerTimes['Fajr'],
                    icon: Icons.wb_twighlight,
                    color: Colors.blue,
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
                    color: Colors.orange,
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
                    color: Colors.deepOrange,
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
                    color: Colors.redAccent,
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
                    color: Colors.indigo,
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
                    color: Colors.purple,
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
                    color: Colors.purpleAccent,
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
                    color: Colors.teal,
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
                    color: Colors.cyan,
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
                    time: 'Add time here',
                    icon: Icons.access_time,
                    color: Colors.deepPurple,
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
