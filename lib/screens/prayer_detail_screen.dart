import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

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
    String fileName;
    switch (widget.prayerName.toLowerCase()) {
      case 'fajr':
        fileName = 'prayers/fajr.json';
        break;
      case 'sunrise':
        fileName = 'prayers/sunrise.json';
        break;
      case 'dhuhr':
        fileName = 'prayers/dhuhr.json';
        break;
      case 'asr':
        fileName = 'prayers/asr.json';
        break;
      case 'maghrib':
        fileName = 'prayers/maghrib.json';
        break;
      case 'isha':
        fileName = 'prayers/isha.json';
        break;
      default:
        throw Exception('Unknown prayer name: ${widget.prayerName}');
    }

    String data = await DefaultAssetBundle.of(context).loadString(fileName);
    final jsonResult = json.decode(data);
    return jsonResult["${widget.prayerName[0].toUpperCase()}${widget.prayerName.substring(1)}Prayer"];
  }

  Future<void> playAudioSteps() async {
    setState(() {
      isPlaying = true;
    });

    for (var step in steps) {
      if (!isPlaying) break; // Stop if user interrupts

      String audioFilePath = 'audio/${widget.prayerName.toLowerCase()}_${step['step_id']}.mp3';
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
