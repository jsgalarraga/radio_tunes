import 'package:flutter/material.dart';
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
  final PageController radiosController;

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
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: radiosController,
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Hero(
            tag: '${radio.id} - card',
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
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
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(child: RadioIcon(radio)),
                    const Gap(8),
                    Center(child: RadioTitle(radio)),
                    Center(child: RadioTags(radio)),
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
