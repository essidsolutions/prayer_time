// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prayer_times_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/prayer_tile.dart';
import 'prayer_detail_screen.dart';
import 'settings_screen.dart';
import 'package:intl/intl.dart';
import '../models/prayer_time_model.dart';
import '../localizations/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    Provider.of<PrayerTimesProvider>(context, listen: false).fetchPrayerTimes(date: selectedDate);
  }

  String? formatPrayerTime(String? time, bool is24HourFormat) {
    if (time == null || time == 'Unknown') {
      return null;
    }

    final format = DateFormat("HH:mm");
    final dateTime = format.parse(time);
    if (is24HourFormat) {
      return format.format(dateTime);
    } else {
      return DateFormat.jm().format(dateTime);
    }
  }

  void _addCustomPrayer(BuildContext context) {
    final prayerNameController = TextEditingController();
    final prayerTimeController = TextEditingController();
    final prayerIconController = TextEditingController();
    final prayerDescriptionController = TextEditingController();
    final prayerRakaaController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.translate('add_custom_prayer')),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: prayerNameController,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.translate('prayer_name')),
                ),
                TextField(
                  controller: prayerTimeController,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.translate('prayer_time')),
                ),
                TextField(
                  controller: prayerIconController,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.translate('icon')),
                ),
                TextField(
                  controller: prayerDescriptionController,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.translate('description')),
                ),
                TextField(
                  controller: prayerRakaaController,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.translate('rakaa')),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.translate('cancel')),
            ),
            TextButton(
              onPressed: () {
                final prayer = Prayer(
                  name: prayerNameController.text,
                  time: prayerTimeController.text,
                  icon: prayerIconController.text,
                  description: prayerDescriptionController.text,
                  rakaa: int.parse(prayerRakaaController.text),
                );
                Provider.of<PrayerTimesProvider>(context, listen: false).addCustomPrayer(prayer);
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.translate('add')),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final prayerTimesProvider = Provider.of<PrayerTimesProvider>(context);
    final isDarkMode = settingsProvider.isDarkMode;
    final is24HourFormat = settingsProvider.is24HourFormat;
    final bgColor = isDarkMode ? Colors.black : Colors.white;
    final borderColor = isDarkMode ? Colors.white : Colors.black;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        iconTheme: IconThemeData(color: borderColor),
        title: Text(AppLocalizations.of(context)!.translate('title'), style: textTheme.titleLarge?.copyWith(color: borderColor)),
        leading: IconButton(
          icon: Icon(Icons.add, color: borderColor),
          onPressed: () {
            _addCustomPrayer(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: borderColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white, // Set the date navigation background to white
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      selectedDate = selectedDate.subtract(Duration(days: 1));
                      Provider.of<PrayerTimesProvider>(context, listen: false)
                          .fetchPrayerTimes(date: selectedDate);
                    });
                  },
                ),
                Column(
                  children: [
                    Text(
                      DateFormat.yMMMd().format(selectedDate),
                      style: textTheme.titleLarge?.copyWith(color: Colors.black),
                    ),
                    Text(
                      prayerTimesProvider.hijriDate.isNotEmpty ? prayerTimesProvider.hijriDate : AppLocalizations.of(context)!.translate('fetching'),
                      style: textTheme.bodyMedium?.copyWith(color: Colors.black),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      selectedDate = selectedDate.add(Duration(days: 1));
                      Provider.of<PrayerTimesProvider>(context, listen: false)
                          .fetchPrayerTimes(date: selectedDate);
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: bgColor,
              child: Consumer<PrayerTimesProvider>(
                builder: (context, provider, child) {
                  if (provider.prayerTimes == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final prayerTimes = provider.prayerTimes!;
                    final orderedPrayers = [
                      {'name': AppLocalizations.of(context)!.translate('imsak'), 'time': prayerTimes.imsak, 'icon': Icons.access_time, 'iconColor': Colors.teal},
                      {'name': AppLocalizations.of(context)!.translate('fajr'), 'time': prayerTimes.fajr, 'icon': Icons.brightness_5, 'iconColor': Colors.blue},
                      {'name': selectedDate.weekday == DateTime.friday ? AppLocalizations.of(context)!.translate('jumaa') : AppLocalizations.of(context)!.translate('dhuhr'), 'time': selectedDate.weekday == DateTime.friday ? '13:00' : prayerTimes.dhuhr, 'icon': Icons.brightness_6, 'iconColor': Colors.orange},
                      {'name': AppLocalizations.of(context)!.translate('asr'), 'time': prayerTimes.asr, 'icon': Icons.brightness_7, 'iconColor': Colors.deepOrange},
                      {'name': AppLocalizations.of(context)!.translate('maghrib'), 'time': prayerTimes.maghrib, 'icon': Icons.brightness_4, 'iconColor': Colors.redAccent},
                      {'name': AppLocalizations.of(context)!.translate('isha'), 'time': prayerTimes.isha, 'icon': Icons.brightness_3, 'iconColor': Colors.indigo},
                      {'name': AppLocalizations.of(context)!.translate('last_third'), 'time': prayerTimes.lastThird, 'icon': Icons.access_time, 'iconColor': Colors.deepPurple},
                    ];

                    final customPrayers = prayerTimes.customPrayers.map((prayer) => {
                      'name': prayer.name,
                      'time': prayer.time,
                      'icon': Icons.access_time, // Replace with the correct icon logic
                      'iconColor': Colors.pink, // Replace with the correct icon color logic
                    }).toList();

                    final allPrayers = orderedPrayers + customPrayers;

                    return ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: allPrayers.length,
                      itemBuilder: (context, index) {
                        final prayer = allPrayers[index];
                        final formattedTime = formatPrayerTime(prayer['time'] as String?, is24HourFormat);
                        return PrayerTile(
                          name: prayer['name'] as String,
                          time: formattedTime ?? 'N/A',
                          icon: prayer['icon'] as IconData,
                          iconColor: prayer['iconColor'] as Color,
                          borderColor: borderColor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrayerDetailScreen(prayerName: prayer['name'] as String),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
