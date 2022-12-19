import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:radio_app/domain/entities/radio_station.dart';
import 'package:radio_app/features/radios_list/view/widgets/play_button.dart';
import 'package:radio_app/features/radios_list/view/widgets/radio_icon.dart';
import 'package:radio_app/utils/colors.dart';

class RadioPlayerPage extends StatelessWidget {
  final RadioStation radio;
  const RadioPlayerPage(this.radio, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const SizedBox(),
        actions: const [CloseButton()],
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const RadioGraphics(),
            RadioData(radio),
            const PlayerControls(),
            const Gap(32),
          ],
        ),
      ),
    );
  }
}

class RadioGraphics extends StatelessWidget {
  const RadioGraphics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageSize = MediaQuery.of(context).size;
    return Container(
      height: pageSize.height * .5,
      width: pageSize.width,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class RadioData extends StatelessWidget {
  final RadioStation radio;
  const RadioData(this.radio, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RadioIcon(radio),
        const Gap(24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                radio.name,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (radio.formattedTags.isNotEmpty) ...[
                const Gap(4),
                Text(
                  radio.formattedTags,
                  style: TextStyle(color: Colors.white.withOpacity(.4), fontSize: 14),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class PlayerControls extends StatelessWidget {
  const PlayerControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const PlayButton(size: 32),
    );
  }
}
