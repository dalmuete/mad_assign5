import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:assign_5/providers/song_provider.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';

class SongPlayerScreen extends StatelessWidget {
  final String songTitle;
  final String songImage;
  final String songPath;

  const SongPlayerScreen({
    Key? key,
    required this.songTitle,
    required this.songImage,
    required this.songPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);
    final AudioPlayer audioPlayer = songProvider.audioPlayer;

    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF282C34), Color(0xFF0D1117)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.1),
                    ),
                    child: Image.asset(
                      songImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(songTitle,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              SizedBox(height: 20.0),
              StreamBuilder<Duration?>(
                stream: audioPlayer.durationStream,
                builder: (context, snapshot) {
                  final duration = snapshot.data ?? Duration.zero;
                  return StreamBuilder<Duration>(
                    stream: audioPlayer.positionStream,
                    builder: (context, snapshot) {
                      var position = snapshot.data ?? Duration.zero;
                      if (position > duration) {
                        position = duration;
                      }
                      final positionText =
                          '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}';
                      final durationText =
                          '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
                      return Column(
                        children: [
                          Text('$positionText / $durationText',
                              style: TextStyle(color: Colors.white)),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbColor: Colors.white,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 8.0),
                              overlayColor: Colors.white.withAlpha(32),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 16.0),
                              activeTrackColor: Color(0xFFEF476F),
                              inactiveTrackColor:
                                  Color(0xFF36B6FF).withOpacity(0.5),
                              trackHeight: 8.0,
                            ),
                            child: Slider(
                              value: position.inMilliseconds.toDouble(),
                              onChanged: (value) {
                                audioPlayer.seek(
                                    Duration(milliseconds: value.toInt()));
                              },
                              min: 0.0,
                              max: duration.inMilliseconds.toDouble(),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.replay_5, size: 32, color: Colors.white),
                    onPressed: () {
                      audioPlayer.seek(Duration(
                          seconds: audioPlayer.position.inSeconds - 5));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                        audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                        size: 48,
                        color: Colors.white),
                    onPressed: () {
                      if (audioPlayer.playing) {
                        audioPlayer.pause();
                      } else {
                        audioPlayer.play();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.forward_5, size: 32, color: Colors.white),
                    onPressed: () {
                      audioPlayer.seek(Duration(
                          seconds: audioPlayer.position.inSeconds + 5));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
