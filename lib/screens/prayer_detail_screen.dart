// prayer_detail_screen.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class PrayerDetailScreen extends StatefulWidget {
  final String prayerName;

  PrayerDetailScreen({required this.prayerName});

  @override
  _PrayerDetailScreenState createState() => _PrayerDetailScreenState();
}

class _PrayerDetailScreenState extends State<PrayerDetailScreen> {
  late List<dynamic> steps;
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  Future<Map<String, dynamic>> loadPrayerSteps(BuildContext context) async {
    final locale = Provider.of<SettingsProvider>(context, listen: false).locale.languageCode;
    final fileName = 'prayers/$locale/${widget.prayerName.toLowerCase()}.json';

    try {
      final data = await rootBundle.loadString(fileName);
      final jsonResult = json.decode(data);
      return jsonResult;
    } catch (e) {
      print('Error loading prayer steps: $e');
      throw Exception('Error loading prayer steps for ${widget.prayerName}');
    }
  }

  Future<void> playAudioSteps() async {
    setState(() {
      isPlaying = true;
    });

    for (var step in steps) {
      if (!isPlaying) break; // Stop if user interrupts

      String audioFilePath = 'assets/audio/${widget.prayerName.toLowerCase()}_${step['step_id']}.mp3';
      print('Playing: $audioFilePath'); // Debugging info

      await audioPlayer.play(DeviceFileSource(audioFilePath));
      await Future.delayed(Duration(seconds: 5));
    }

    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.prayerName),
        actions: [
          if (!isPlaying)
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () => playAudioSteps(),
            ),
          if (isPlaying)
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: () {
                audioPlayer.stop();
                setState(() {
                  isPlaying = false;
                });
              },
            ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: loadPrayerSteps(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading prayer steps'));
          } else {
            steps = snapshot.data!['steps'];
            return ListView.builder(
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(steps[index]['title']),
                  subtitle: Text(steps[index]['description']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
