import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../providers/prayer_times_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final prayerTimesProvider = Provider.of<PrayerTimesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Dark Mode'),
              value: settingsProvider.isDarkMode,
              onChanged: (value) {
                settingsProvider.toggleDarkMode();
              },
            ),
            DropdownButton<String>(
              value: settingsProvider.selectedFont,
              onChanged: (String? newValue) {
                settingsProvider.setSelectedFont(newValue!);
              },
              items: <String>['Roboto', 'Lato', 'OpenSans']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Slider(
              label: 'Font Size',
              min: 10,
              max: 30,
              value: settingsProvider.fontSize,
              onChanged: (value) {
                settingsProvider.setFontSize(value);
              },
            ),
            CheckboxListTile(
              title: Text('Bold'),
              value: settingsProvider.isBold,
              onChanged: (value) {
                settingsProvider.toggleBold();
              },
            ),
            CheckboxListTile(
              title: Text('Italic'),
              value: settingsProvider.isItalic,
              onChanged: (value) {
                settingsProvider.toggleItalic();
              },
            ),
            SwitchListTile(
              title: Text('24-Hour Format'),
              value: settingsProvider.is24HourFormat,
              onChanged: (value) {
                settingsProvider.toggleTimeFormat();
              },
            ),
            SizedBox(height: 20),
            Text(
              'Location:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              prayerTimesProvider.location.isNotEmpty
                  ? prayerTimesProvider.location
                  : 'Fetching location...',
              style: TextStyle(
                color: settingsProvider.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Data Info:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              prayerTimesProvider.isCachedData
                  ? 'Data loaded from cache'
                  : 'Data fetched from the API',
              style: TextStyle(
                color: settingsProvider.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Text(
              'Date Range: Jan 1, ${DateTime.now().year} - Dec 31, ${DateTime.now().year}',
              style: TextStyle(
                color: settingsProvider.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
