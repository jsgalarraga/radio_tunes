import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_app/domain/entities/radio_station.dart';
import 'package:radio_app/domain/provider/providers.dart';
import 'package:radio_app/features/radio_player/model/radio_player_model.dart';
import 'package:radio_app/features/radio_player/view/widgets/player_button.dart';
import 'package:radio_app/utils/colors.dart';

class CardPlayerButton extends ConsumerWidget {
  final RadioStation radio;
  final double size;
  const CardPlayerButton(this.radio, {Key? key, this.size = 20}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(radioPlayerProvider);
    if (radio.id == playerState.radio?.id) {
      if (playerState is Loading) {
        return Container(
          margin: const EdgeInsets.all(6),
          height: 24,
          width: 24,
          child: const CircularProgressIndicator(color: AppColors.foregroundColor, strokeWidth: 2),
        );
      } else if (playerState is Playing) {
        return StopButton(size: size);
      } else {
        return PlayButton(size: size);
      }
    } else {
      return PlayButton(size: size);
    }
  }
}
