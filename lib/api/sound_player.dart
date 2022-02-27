import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:audioplayers/audioplayers.dart';

final pathToSaveAudio = 'audio_example.aac';

class SoundPlayer {
  FlutterSoundPlayer? _audioPlayer;
  AudioPlayer audioPlayer = AudioPlayer();

  Future init() async {
    _audioPlayer = FlutterSoundPlayer();

    await _audioPlayer!.openAudioSession();
  }

  void dispose() {
    _audioPlayer!.closeAudioSession();
    _audioPlayer = null;
  }

  Future play(VoidCallback whenFinished) async {
    await _audioPlayer!.startPlayer(
      fromURI: pathToSaveAudio,
      whenFinished: whenFinished,
    );
  }

  Future playLocal() async {
    int result = await audioPlayer.play(pathToSaveAudio, isLocal: true);
  }

  Future playUrl(String url) async {
    int result = await audioPlayer.play(url);
    if (result == 1) {
      print('successfully playing audio');
    }
  }

  Future stop() async {
    await _audioPlayer!.stopPlayer();
  }

  Future togglePlaying({required VoidCallback whenFinished}) async {
    if (_audioPlayer!.isStopped) {
      await play(whenFinished);
    } else {
      await stop();
    }
  }
}
