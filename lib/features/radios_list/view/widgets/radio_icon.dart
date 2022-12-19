import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:radio_app/domain/entities/radio_station.dart';
import 'package:radio_app/utils/colors.dart';

class RadioIcon extends StatelessWidget {
  final RadioStation radio;
  const RadioIcon(this.radio, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${radio.id} - icon',
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 40,
        width: 40,
        child: radio.icon.isEmpty
            ? const Icon(Icons.radio, color: AppColors.backgroundColor)
            : CachedNetworkImage(imageUrl: radio.icon),
      ),
    );
  }
}
