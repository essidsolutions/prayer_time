import 'package:flutter/material.dart';

class PrayerTile extends StatelessWidget {
  final String name;
  final String time;
  final IconData icon; // Use IconData instead of custom icon path
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: borderColor, width: 1),
      ),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon, color: iconColor), // Use built-in Flutter icon
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            Text(
              time,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
