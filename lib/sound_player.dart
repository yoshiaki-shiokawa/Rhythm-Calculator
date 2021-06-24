import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';
import 'package:tuple/tuple.dart';

class SoundPlayer {
  int tempo = 60;
  bool playing = false;
  waveTypes waveType = waveTypes.SINUSOIDAL;
  List<Tuple2<double, int>> track = [];

  SoundPlayer() {
    SoundGenerator.init(96000);
    SoundGenerator.setAutoUpdateOneCycleSample(true);
    SoundGenerator.refreshOneCycleData();
    SoundGenerator.setVolume(1);
    SoundGenerator.setBalance(0);
    setTone('Happy Mellow');
    debugPrint("Sound Generator initiallised");
  }

  void setTone(String fileName) {
    SoundGenerator.setWaveType(waveType);
  }

  bool isPlaying() {
    return playing;
  }

  void setTempo(int tempo) {
    this.tempo = tempo;
  }

  void addNoteToTrack(double length, int pitch) {
    track.add(Tuple2<double, int>(length, pitch));
  }

  void deleteNotefromTrack() {
    if (track.isNotEmpty) {
      track = track.sublist(0, track.length - 2);
    }
  }

  void clearTrack() {
    track = [];
  }

  Future<void> play() async {
    playing = true;
    playing = playTrack(track);
  }

  bool playTrack(List<Tuple2<double, int>> track) {
    for (Tuple2<double, int> note in track) {
      if (note.item1 > 0) {
        SoundGenerator.setFrequency(261.625565);
        SoundGenerator.play();
      }
      sleep(Duration(microseconds: 60 * note.item1.abs() * 1000000 ~/ tempo));
      SoundGenerator.stop();
    }
    return false;
  }

  void playTest() {
    playing = true;
    SoundGenerator.setFrequency(261.625565);
    SoundGenerator.play();
  }

  void stopPlaying() {
    playing = false;
    SoundGenerator.stop();
  }

  void dispose() {
    SoundGenerator.release();
  }
}
