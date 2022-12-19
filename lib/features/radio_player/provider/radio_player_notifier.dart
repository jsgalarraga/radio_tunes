import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_app/domain/entities/radio_station.dart';
import 'package:radio_app/features/radio_player/model/radio_player_model.dart';

class RadioPlayerNotifier extends StateNotifier<RadioPlayerBaseModel> {
  RadioPlayerNotifier() : super(NotPlaying.empty());

  final player = AudioPlayer();

  void initialize() {
    player.playerStateStream.listen((event) {
      if (event.playing) {
        state = Playing(state.radio);
      } else {
        switch (event.processingState) {
          case ProcessingState.idle:
          case ProcessingState.ready:
          case ProcessingState.completed:
            state = NotPlaying(state.radio);
            break;
          case ProcessingState.buffering:
          case ProcessingState.loading:
            state = Loading(state.radio);
            break;
        }
      }
    });
  }

  void stopAndDispose() {
    player.stop();
    player.dispose();
  }

  void loadRadioAndPlay(RadioStation radio) async {
    state = Loading(radio);
    player.stop();
    await player.setUrl(radio.url);
    player.play();
  }

  void play() async {
    player.play();
  }

  void pausePlaying() async {
    player.pause();
  }

  void stopPlaying() async {
    player.stop();
  }
}
