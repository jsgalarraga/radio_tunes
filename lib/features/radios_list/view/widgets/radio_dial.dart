import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:radio_app/utils/colors.dart';

class RadioDial extends StatelessWidget {
  final int tunedRadio;
  final int totalRadios;
  const RadioDial(
    this.tunedRadio, {
    super.key,
    required this.totalRadios,
  });

  @override
  Widget build(BuildContext context) {
    final position = (tunedRadio / totalRadios * 2) - 1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            height: 80,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(3),
              boxShadow: const [
                BoxShadow(
                  inset: true,
                  color: Colors.black45,
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(
                      41,
                      (index) => Container(
                        height: index % 5 == 0 ? 40 : 24,
                        width: 2,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(position, 0),
                  child: Container(
                    width: 4,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
