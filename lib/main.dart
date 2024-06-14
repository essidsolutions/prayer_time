import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/prayer_times_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PrayerTimesProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return MaterialApp(
            title: 'Prayer Times',
            theme: settingsProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
