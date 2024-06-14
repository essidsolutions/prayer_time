import 'package:flutter/material.dart';

class PrayerTile extends StatelessWidget {
  final String name;
  final String time;
  final IconData icon;
  final Color iconColor;
  final Color borderColor;
  final VoidCallback onTap;

  const PrayerTile({
    Key? key,
    required this.name,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.borderColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            SizedBox(width: 16.0),
            Expanded(child: Text(name, style: TextStyle(fontSize: 18.0))),
            Text(time, style: TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}
