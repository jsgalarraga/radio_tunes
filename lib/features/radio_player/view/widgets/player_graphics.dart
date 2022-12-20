import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_app/domain/entities/radio_station.dart';
import 'package:radio_app/domain/provider/providers.dart';
import 'package:radio_app/features/radio_player/model/radio_player_view_model.dart';
import 'package:radio_app/utils/colors.dart';

const double barWidth = 6;
const double barGap = 4;

class RadioGraphics extends ConsumerWidget {
  final RadioStation radio;
  const RadioGraphics(this.radio, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageSize = MediaQuery.of(context).size;
    return Hero(
      tag: '${radio.id} - card',
      child: Container(
        padding: const EdgeInsets.all(24),
        height: pageSize.height * .4,
        width: pageSize.width,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: LayoutBuilder(
          builder: (_, constraints) {
            final barCount = constraints.maxWidth ~/ (barWidth + barGap);
            return StreamBuilder(
              stream: randomNumStream(),
              builder: (_, snapshot) {
                final state = ref.watch(radioPlayerProvider);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      barCount,
                      (index) {
                        final data = snapshot.data?[index];
                        final height = (state is Playing) ? data : barWidth * 2;
                        return AudioBar(height);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class AudioBar extends StatelessWidget {
  final double? height;
  const AudioBar(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: height?.toDouble() ?? 0,
      width: barWidth,
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(50),
      ),
      duration: const Duration(milliseconds: 400),
    );
  }
}

Stream<List<double>> randomNumStream() async* {
  while (true) {
    await Future.delayed(const Duration(milliseconds: 400));
    var rng = math.Random();
    final list = List.generate(200, (index) => rng.nextInt(140).toDouble());
    yield list;
  }
}
