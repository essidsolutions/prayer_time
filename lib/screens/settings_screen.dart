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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Settings', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white, // Ensure the background is white
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: Text('Dark Mode', style: TextStyle(color: Colors.black)),
                value: settingsProvider.isDarkMode,
                onChanged: (value) {
                  settingsProvider.toggleDarkMode();
                },
              ),
              SizedBox(height: 10),
              Text('Font', style: TextStyle(color: Colors.black)),
              DropdownButton<String>(
                value: settingsProvider.selectedFont,
                onChanged: (String? newValue) {
                  settingsProvider.setSelectedFont(newValue!);
                },
                items: <String>['Roboto', 'Lato', 'OpenSans']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Colors.black)),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Text('Font Size', style: TextStyle(color: Colors.black)),
              Slider(
                label: 'Font Size',
                min: 10,
                max: 30,
                value: settingsProvider.fontSize,
                onChanged: (value) {
                  settingsProvider.setFontSize(value);
                },
              ),
              SizedBox(height: 10),
              Text('Font Style', style: TextStyle(color: Colors.black)),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Bold', style: TextStyle(color: Colors.black)),
                      value: settingsProvider.isBold,
                      onChanged: (value) {
                        settingsProvider.toggleBold();
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Italic', style: TextStyle(color: Colors.black)),
                      value: settingsProvider.isItalic,
                      onChanged: (value) {
                        settingsProvider.toggleItalic();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SwitchListTile(
                title: Text('24-Hour Format', style: TextStyle(color: Colors.black)),
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
                  color: Colors.black,
                ),
              ),
              Text(
                prayerTimesProvider.location.isNotEmpty
                    ? prayerTimesProvider.location
                    : 'Fetching location...',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Data Info:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                prayerTimesProvider.isCachedData
                    ? 'Data loaded from cache'
                    : 'Data fetched from the API',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                'Date Range: Jan 1, ${DateTime.now().year} - Dec 31, ${DateTime.now().year}',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
