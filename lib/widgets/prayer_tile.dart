import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrayerTile extends StatelessWidget {
  final String name;
  final String time;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  PrayerTile({required this.name, required this.time, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: GoogleFonts.lato(
                textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Text(
              time,
              style: GoogleFonts.lato(
                textStyle: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
