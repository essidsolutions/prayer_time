import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prayer_times_provider.dart';
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
        title: Text('PrayerTime'),
      ),
      body: Consumer<PrayerTimesProvider>(
        builder: (context, provider, child) {
          if (provider.prayerTimes.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: provider.prayerTimes.keys.length,
              itemBuilder: (context, index) {
                String key = provider.prayerTimes.keys.elementAt(index);
                return ListTile(
                  title: Text(key),
                  subtitle: Text(provider.prayerTimes[key]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrayerDetailScreen(prayerName: key),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
