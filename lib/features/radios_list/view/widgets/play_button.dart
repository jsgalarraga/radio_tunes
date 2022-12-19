import 'package:flutter/material.dart';
import 'package:radio_app/utils/colors.dart';

class PlayButton extends StatelessWidget {
  final double size;
  const PlayButton({Key? key, this.size = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.foregroundColor,
      ),
      child: Icon(
        Icons.play_arrow,
        size: size,
        color: AppColors.backgroundColor,
      ),
    );
  }
}
