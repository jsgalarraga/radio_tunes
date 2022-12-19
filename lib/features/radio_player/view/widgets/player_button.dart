import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_app/domain/entities/radio_station.dart';
import 'package:radio_app/domain/provider/providers.dart';
import 'package:radio_app/features/radio_player/model/radio_player_model.dart';
import 'package:radio_app/utils/colors.dart';

class PlayerButton extends ConsumerWidget {
  final RadioStation radio;
  final double size;
  const PlayerButton(this.radio, {Key? key, this.size = 32}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(radioPlayerProvider);
    if (playerState is Loading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.foregroundColor));
    } else if (playerState is Playing) {
      return PlayerBaseButton(
        onTap: () => ref.read(radioPlayerProvider.notifier).pausePlaying(),
        size: size,
        icon: Icons.stop,
      );
    } else {
      return PlayerBaseButton(
        onTap: () => ref.read(radioPlayerProvider.notifier).play(),
        size: size,
        icon: Icons.play_arrow,
      );
    }
  }
}

class PlayerBaseButton extends StatelessWidget {
  final Function() onTap;
  final double size;
  final IconData icon;
  const PlayerBaseButton({super.key, required this.onTap, required this.size, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      color: AppColors.foregroundColor,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: size, color: AppColors.backgroundColor),
        ),
      ),
    );
    ;
  }
}
