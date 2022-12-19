import 'package:flutter/material.dart';
import 'package:radio_app/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class RadiosListLoadingBody extends StatelessWidget {
  const RadiosListLoadingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: AppColors.backgroundColor,
      child: Shimmer.fromColors(
        baseColor: AppColors.secondaryColor.withOpacity(.4),
        highlightColor: AppColors.secondaryColor,
        period: const Duration(milliseconds: 2500),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return ListView(
              children: [
                ...List.generate(
                  5,
                  (_) => Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      height: 144,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
