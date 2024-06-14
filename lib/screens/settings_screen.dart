import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
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
          ],
        ),
      ),
    );
  }
}
