import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:radio_app/domain/entities/radio_station.dart';
import 'package:radio_app/domain/provider/providers.dart';
import 'package:radio_app/features/radio_player/view/radio_player_page.dart';
import 'package:radio_app/features/radios_list/model/radios_list_view_model.dart';
import 'package:radio_app/features/radios_list/view/error_body.dart';
import 'package:radio_app/features/radios_list/view/loading_body.dart';
import 'package:radio_app/features/radios_list/view/widgets/card_player_button.dart';
import 'package:radio_app/features/radios_list/view/widgets/circular_knob.dart';
import 'package:radio_app/features/radios_list/view/widgets/radio_dial.dart';
import 'package:radio_app/features/radios_list/view/widgets/radio_icon.dart';
import 'package:radio_app/features/radios_list/view/widgets/radio_title.dart';
import 'package:radio_app/utils/colors.dart';
import 'package:radio_app/utils/custom_page_route.dart';

class RadioTunerPage extends ConsumerStatefulWidget {
  const RadioTunerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RadiosListPageState();
}

class _RadiosListPageState extends ConsumerState<RadioTunerPage> {
  int radiosLength = 0;

  @override
  void initState() {
    super.initState();
    ref.read(radiosListProvider.notifier).fetch();
  }

  @override
  Widget build(BuildContext context) {
    final radiosListViewModel = ref.watch(radiosListProvider);
    Widget body;
    if (radiosListViewModel is Loading) {
      body = const RadiosListLoadingBody();
    } else if (radiosListViewModel is RadiosListViewModel) {
      body = RadioTunerFullBody(radiosListViewModel);
    } else {
      body = const RadiosListErrorBody();
    }

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('RadioTunes'),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: body,
    );
  }
}

class RadioTunerFullBody extends StatefulWidget {
  final RadiosListViewModel viewModel;
  const RadioTunerFullBody(this.viewModel, {Key? key}) : super(key: key);

  @override
  State<RadioTunerFullBody> createState() => _RadioTunerFullBodyState();
}

class _RadioTunerFullBodyState extends State<RadioTunerFullBody> {
  double knobAngle = 0;
  int tunedRadio = 0;

  @override
  Widget build(BuildContext context) {
    final radiosList = widget.viewModel.radiosList;
    return Center(
      child: Column(
        children: [
          const Gap(24),
          RadioDial(
            tunedRadio,
            totalRadios: radiosList.length,
          ),
          const Gap(24),
          Text(
            tunedRadio.toString(),
            style: const TextStyle(color: AppColors.foregroundColor),
          ),
          const Gap(24),
          CircularKnob(
            currentAngle: knobAngle,
            onUpdate: (double value) {
              final newTunedRadio = value ~/ 8;
              if (isTunedRadioAllowed(newTunedRadio, radiosList.length)) {
                setState(() {
                  knobAngle = value;
                  tunedRadio = newTunedRadio;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  bool isTunedRadioAllowed(int newTunedRadio, int radiosListCount) {
    return (newTunedRadio >= 0) && (newTunedRadio < radiosListCount);
  }
}

class RadiosListElement extends ConsumerWidget {
  final RadioStation radio;
  const RadiosListElement(this.radio, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final borderRadius = BorderRadius.circular(8);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RadioIcon(radio),
                          const Gap(8),
                          RadioTitle(radio),
                          const Gap(8),
                          RadioTags(radio),
                        ],
                      ),
                    ),
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
