import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/prayer_times_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PrayerTimesProvider(),
      child: MaterialApp(
        title: 'Prayer Times',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
