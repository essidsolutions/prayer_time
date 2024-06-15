import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../providers/prayer_times_provider.dart';
import '../localizations/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final prayerTimesProvider = Provider.of<PrayerTimesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(AppLocalizations.of(context)!.translate('settings'), style: TextStyle(color: Colors.black)),
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
                title: Text(AppLocalizations.of(context)!.translate('dark_mode'), style: TextStyle(color: Colors.black)),
                value: settingsProvider.isDarkMode,
                onChanged: (value) {
                  settingsProvider.toggleDarkMode();
                },
              ),
              SizedBox(height: 10),
              Text(AppLocalizations.of(context)!.translate('font'), style: TextStyle(color: Colors.black)),
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
              Text(AppLocalizations.of(context)!.translate('font_size'), style: TextStyle(color: Colors.black)),
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
              Text(AppLocalizations.of(context)!.translate('font_style'), style: TextStyle(color: Colors.black)),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Text(AppLocalizations.of(context)!.translate('bold'), style: TextStyle(color: Colors.black)),
                      value: settingsProvider.isBold,
                      onChanged: (value) {
                        settingsProvider.toggleBold();
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text(AppLocalizations.of(context)!.translate('italic'), style: TextStyle(color: Colors.black)),
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
                title: Text(AppLocalizations.of(context)!.translate('24_hour_format'), style: TextStyle(color: Colors.black)),
                value: settingsProvider.is24HourFormat,
                onChanged: (value) {
                  settingsProvider.toggleTimeFormat();
                },
              ),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.translate('language'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              DropdownButton<Locale>(
                value: settingsProvider.locale,
                onChanged: (Locale? newLocale) {
                  settingsProvider.setLocale(newLocale!);
                },
                items: <Locale>[
                  Locale('en'),
                  Locale('ar'),
                ].map<DropdownMenuItem<Locale>>((Locale locale) {
                  return DropdownMenuItem<Locale>(
                    value: locale,
                    child: Text(
                      locale.languageCode == 'en'
                          ? AppLocalizations.of(context)!.translate('english')
                          : AppLocalizations.of(context)!.translate('arabic'),
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.translate('location'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                prayerTimesProvider.location.isNotEmpty
                    ? prayerTimesProvider.location
                    : AppLocalizations.of(context)!.translate('fetching'),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.translate('data_info'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                prayerTimesProvider.isCachedData
                    ? AppLocalizations.of(context)!.translate('data_loaded_from_cache')
                    : AppLocalizations.of(context)!.translate('data_fetched_from_api'),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.translate('date_range').replaceFirst('{year}', DateTime.now().year.toString()),
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
