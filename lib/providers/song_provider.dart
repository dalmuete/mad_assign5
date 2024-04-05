import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SongProvider extends ChangeNotifier {
  late AudioPlayer _audioPlayer;
  late bool _isPlaying = false;

  SongProvider() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });
  }

  bool get isPlaying => _isPlaying;

  AudioPlayer get audioPlayer => _audioPlayer;

  void play(String songPath) async {
    await _audioPlayer.setAsset(songPath);
    await _audioPlayer.setLoopMode(LoopMode.off);
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void resume() {
    _audioPlayer.play();
  }
}
