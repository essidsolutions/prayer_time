import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'prayer_detail_screen.dart';
import '../services/location_service.dart';
import '../services/prayer_time_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locationService = Provider.of<LocationService>(context);
    final prayerTimeService = Provider.of<PrayerTimeService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Time'),
      ),
      body: FutureBuilder(
        future: prayerTimeService.getPrayerTimes(locationService.currentLocation),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching prayer times'));
          }
          final prayerTimes = snapshot.data;
          return Column(
            children: [
              Text('City: ${locationService.cityName}'),
              Expanded(
                child: ListView.builder(
                  itemCount: prayerTimes.length,
                  itemBuilder: (context, index) {
                    final prayer = prayerTimes[index];
                    return ListTile(
                      title: Text(prayer.name),
                      subtitle: Text(prayer.time),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrayerDetailScreen(prayer: prayer),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
