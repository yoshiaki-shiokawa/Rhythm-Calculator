import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:flutter_sequencer/instrument.dart';
import 'package:flutter_sequencer/sequence.dart';
import 'package:flutter_sequencer/track.dart';
import 'player_constants.dart';
import 'project_state.dart';
import 'step_sequencer_state.dart';

/*
class SoundPlayer extends StatefulWidget {
  @override
  _SoundPlayerState createState() => _SoundPlayerState();
}
*/

class SoundPlayer {
  final sequence =
      Sequence(tempo: INITIAL_TEMPO, endBeat: INITIAL_STEP_COUNT.toDouble());
  Map<int, StepSequencerState> trackStepSequencerStates = {};
  List<Track> tracks = [];
  Map<int, double> trackVolumes = {};
  Track selectedTrack;
  Ticker ticker;
  double tempo = INITIAL_TEMPO;
  int stepCount = INITIAL_STEP_COUNT;
  double position = 0.0;
  bool isPlaying = false;
  bool isLooping = INITIAL_IS_LOOPING;

  void create() {
    final instruments = [
      SfzInstrument(path: "assets/sfz/City Piano.sfz", isAsset: true)
    ];

    sequence.createTracks(instruments).then((tracks) {
      this.tracks = tracks;
      tracks.forEach((track) {
        trackVolumes[track.id] = 0.0;
        trackStepSequencerStates[track.id] = StepSequencerState();
      });

      this.selectedTrack = tracks[0];
    });

    tempo = sequence.getTempo();
    position = sequence.getBeat();
    isPlaying = sequence.getIsPlaying();

    tracks.forEach((track) {
      trackVolumes[track.id] = track.getVolume();
    });
  }

  convert(List<List<int>> _track, {int trackNum = 0}) {
    double lastposition = 0.0;
    double length = 0.0;
    for (List<int> x in _track) {
      if (x[0].abs() < 10) {
        length = 1 / pow(2, x[0] - 1);
      } else {
        length = (1 / pow(2, x[0] - 11)) * 3 / 2;
      }
      if (x[0] > 0) {
        tracks[trackNum].addNote(
          startBeat: lastposition,
          durationBeats: length,
          noteNumber: x[1],
          velocity: x[2] / 10,
        );
      }
      lastposition += length;
    }
  }

  clearTrack({int trackNum = 0}) {
    tracks[trackNum].clearEvents();
  }

  handleTogglePlayPause() {
    if (isPlaying) {
      //sequence.pause();
      handleStop();
    } else {
      sequence.play();
    }
  }

  handleStop() {
    sequence.stop();
  }

  handleSetLoop(bool nextIsLooping) {
    if (nextIsLooping) {
      sequence.setLoop(0, stepCount.toDouble());
    } else {
      sequence.unsetLoop();
    }

    isLooping = nextIsLooping;
  }

  handleToggleLoop() {
    final nextIsLooping = !isLooping;

    handleSetLoop(nextIsLooping);
  }

  handleStepCountChange(int nextStepCount) {
    if (nextStepCount < 1) return;

    sequence.setEndBeat(nextStepCount.toDouble());

    if (isLooping) {
      final nextLoopEndBeat = nextStepCount.toDouble();

      sequence.setLoop(0, nextLoopEndBeat);
    }

    stepCount = nextStepCount;
    tracks.forEach((track) => syncTrack(track));
  }

  handleTempoChange(double nextTempo) {
    if (nextTempo <= 0) return;
    sequence.setTempo(nextTempo);
  }

  handleTrackChange(Track nextTrack) {
    selectedTrack = nextTrack;
  }

  handleVolumeChange(double nextVolume) {
    selectedTrack.changeVolumeNow(volume: nextVolume);
  }

  handleVelocitiesChange(
      int trackId, int step, int noteNumber, double velocity) {
    final track = tracks.firstWhere((track) => track.id == trackId);

    trackStepSequencerStates[trackId].setVelocity(step, noteNumber, velocity);

    syncTrack(track);
  }

  syncTrack(track) {
    track.clearEvents();
    trackStepSequencerStates[track.id]
        .iterateEvents((step, noteNumber, velocity) {
      if (step < stepCount) {
        track.addNote(
            noteNumber: noteNumber,
            velocity: velocity,
            startBeat: step.toDouble(),
            durationBeats: 1.0);
      }
    });
    track.syncBuffer();
  }

  loadProjectState(ProjectState projectState) {
    handleStop();

    trackStepSequencerStates[tracks[0].id] = projectState.drumState;
    trackStepSequencerStates[tracks[1].id] = projectState.pianoState;
    trackStepSequencerStates[tracks[2].id] = projectState.bassState;

    handleStepCountChange(projectState.stepCount);
    handleTempoChange(projectState.tempo);
    handleSetLoop(projectState.isLooping);

    syncTrack(tracks[0]);
    syncTrack(tracks[1]);
    syncTrack(tracks[2]);
  }

  handleReset() {
    loadProjectState(ProjectState.empty());
  }
}
