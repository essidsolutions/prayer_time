import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class PrayerTile extends StatelessWidget {
  final String name;
  final String time;
  final IconData icon;
  final Color iconColor;
  final Color borderColor;
  final VoidCallback onTap;

  PrayerTile({
    required this.name,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: borderColor, width: 1),
      ),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                fontWeight: settingsProvider.isBold ? FontWeight.bold : FontWeight.normal,
                fontStyle: settingsProvider.isItalic ? FontStyle.italic : FontStyle.normal,
                fontSize: settingsProvider.fontSize,
                fontFamily: settingsProvider.selectedFont,
                color: settingsProvider.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Text(
              time,
              style: TextStyle(
                color: settingsProvider.isDarkMode ? Colors.white : Colors.grey,
                fontSize: settingsProvider.fontSize,
                fontFamily: settingsProvider.selectedFont,
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
