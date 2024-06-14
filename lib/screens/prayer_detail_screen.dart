import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Prayer {
  final String name;
  final String time;
  final int rakaat;

  Prayer({required this.name, required this.time, required this.rakaat});
}

class PrayerDetailScreen extends StatelessWidget {
  final Prayer prayer;

  PrayerDetailScreen({required this.prayer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(prayer.name),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrayerInfoScreen(prayer: prayer),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Rakaat: ${prayer.rakaat}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Start the prayer sequence
              },
              child: Text('Start Praying'),
            ),
          ],
        ),
      ),
    );
  }
}

class PrayerInfoScreen extends StatelessWidget {
  final Prayer prayer;

  PrayerInfoScreen({required this.prayer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${prayer.name} Information'),
      ),
      body: Center(
        child: Text('Information about ${prayer.name}'),
      ),
    );
  }
}
