import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:radio_app/domain/entities/radio_station.dart';
import 'package:radio_app/domain/provider/providers.dart';
import 'package:radio_app/features/radio_player/view/radio_player_page.dart';
import 'package:radio_app/features/radios_list/view/widgets/card_player_button.dart';
import 'package:radio_app/features/radios_list/view/widgets/radio_icon.dart';
import 'package:radio_app/features/radios_list/view/widgets/radio_title.dart';
import 'package:radio_app/utils/colors.dart';
import 'package:radio_app/utils/custom_page_route.dart';

class RadiosCarrousel extends StatelessWidget {
  final int tunedRadioIndex;
  final List<RadioStation> radiosList;
  final ScrollController radiosController;

  const RadiosCarrousel({
    super.key,
    required this.tunedRadioIndex,
    required this.radiosList,
    required this.radiosController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        controller: radiosController,
        scrollDirection: Axis.horizontal,
        children: radiosList.map((e) => RadioElement(e)).toList(),
      ),
    );
  }
}

class RadioElement extends ConsumerWidget {
  final RadioStation radio;
  const RadioElement(this.radio, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final borderRadius = BorderRadius.circular(8);
    final width = MediaQuery.of(context).size.width / 2;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Hero(
            tag: '${radio.id} - card',
            child: Container(
              height: 100,
              width: width,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: borderRadius,
              ),
            ),
          ),
          Material(
            color: AppColors.secondaryColor,
            borderRadius: borderRadius,
            child: InkWell(
              borderRadius: borderRadius,
              highlightColor: AppColors.splashColor,
              splashColor: AppColors.splashColor,
              onTap: () {
                final state = ref.read(radioPlayerProvider);
                if (state.radio != radio) {
                  ref.read(radioPlayerProvider.notifier).loadRadioAndPlay(radio);
                }
                Navigator.of(context).push(
                  CustomPageRoute(RadioPlayerPage(radio)),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      inset: true,
                      color: Colors.black45,
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RadioIcon(radio),
                    const Gap(8),
                    RadioTitle(radio),
                    RadioTags(radio),
                    const Gap(8),
                    Hero(
                      tag: '${radio.id} - player controls',
                      child: CardPlayerButton(radio),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
