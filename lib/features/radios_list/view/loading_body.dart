import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:radio_app/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class RadiosListLoadingBody extends StatelessWidget {
  const RadiosListLoadingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Shimmer.fromColors(
        baseColor: AppColors.secondaryColor.withOpacity(.4),
        highlightColor: AppColors.secondaryColor,
        period: const Duration(milliseconds: 2500),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final width = MediaQuery.of(context).size.width;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 250,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const Gap(24),
                      Container(
                        height: 250,
                        width: width / 2,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const Gap(24),
                      Container(
                        height: 250,
                        width: width / 2,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  height: 80,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondaryColor,
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
