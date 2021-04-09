import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:tuple/tuple.dart';

class SoundPlayer {
  FlutterMidi player = FlutterMidi();
  int tempo = 60;
  bool playing = false;
  List<Tuple2<double, int>> track = List.empty();

  void setTone(String fileName) {
    rootBundle
        .load("assets/sf2/$fileName.sf2")
        .then((file) => player.prepare(sf2: file, name: "$fileName.sf2"));
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
    track = List.empty();
  }

  Future<void> playTrack() async {
    playing = true;
    for (Tuple2<double, int> note in track) {
      if (playing) {
        if (note.item1 > 0) {
          player.playMidiNote(midi: note.item2);
        }
        sleep(Duration(microseconds: 60 * note.item1 * 1000000 ~/ tempo));
        player.stopMidiNote(midi: note.item2);
      }
    }
  }

  void stopPlaying() {
    playing = false;
  }
}
