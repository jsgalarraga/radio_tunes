import 'package:flutter/material.dart';
import 'package:radio_app/domain/entities/radio_station.dart';

class RadioTitle extends StatelessWidget {
  final RadioStation radio;
  const RadioTitle(this.radio, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${radio.id} - title',
      child: Material(
        color: Colors.transparent,
        child: Text(
          radio.name,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class RadioTags extends StatelessWidget {
  final RadioStation radio;
  const RadioTags(this.radio, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${radio.id} - tags',
      child: Material(
        color: Colors.transparent,
        child: Text(
          radio.formattedTags,
          style: TextStyle(color: Colors.white.withOpacity(.4), fontSize: 14),
        ),
      ),
    );
  }
}
