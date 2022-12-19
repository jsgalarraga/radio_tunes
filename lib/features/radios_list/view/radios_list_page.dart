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
import 'package:radio_app/features/radio_player/view/widgets/player_button.dart';
import 'package:radio_app/features/radios_list/view/widgets/card_player_button.dart';
import 'package:radio_app/features/radios_list/view/widgets/radio_icon.dart';
import 'package:radio_app/utils/colors.dart';

class RadiosListPage extends ConsumerStatefulWidget {
  const RadiosListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RadiosListPageState();
}

class _RadiosListPageState extends ConsumerState<RadiosListPage> {
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
      body = RadiosListFullBody(radiosListViewModel);
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

class RadiosListFullBody extends StatelessWidget {
  final RadiosListViewModel viewModel;
  const RadiosListFullBody(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radiosList = viewModel.radiosList;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
        itemBuilder: (context, index) => RadiosListElement(radiosList[index]),
        itemCount: radiosList.length,
      ),
    );
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
      child: Material(
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
              MaterialPageRoute(builder: (_) => RadioPlayerPage(radio)),
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
                      Text(
                        radio.name,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(8),
                      Text(
                        radio.formattedTags,
                        style: TextStyle(color: Colors.white.withOpacity(.4), fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                CardPlayerButton(radio),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
