import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/prayer_times_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
            theme: ThemeData(
              brightness: settingsProvider.isDarkMode ? Brightness.dark : Brightness.light,
              textTheme: TextTheme(
                titleLarge: TextStyle(
                  fontFamily: settingsProvider.selectedFont,
                  fontSize: settingsProvider.fontSize,
                  fontWeight: settingsProvider.isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: settingsProvider.isItalic ? FontStyle.italic : FontStyle.normal,
                ),
                bodyLarge: TextStyle(
                  fontFamily: settingsProvider.selectedFont,
                  fontSize: settingsProvider.fontSize,
                  fontWeight: settingsProvider.isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: settingsProvider.isItalic ? FontStyle.italic : FontStyle.normal,
                ),
              ),
            ),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
