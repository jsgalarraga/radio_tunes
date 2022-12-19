import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:radio_app/domain/entities/radio_station.dart';
import 'package:radio_app/domain/provider/providers.dart';
import 'package:radio_app/features/radios_list/model/radios_list_view_model.dart';
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
    if (radiosListViewModel is Loading) {
      return const RadiosListLoadingBody();
    } else if (radiosListViewModel is RadiosListViewModel) {
      return RadiosListFullBody(radiosListViewModel);
    } else {
      return const RadiosListErrorBody();
    }
  }
}

class RadiosListLoadingBody extends StatelessWidget {
  const RadiosListLoadingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class RadiosListErrorBody extends StatelessWidget {
  const RadiosListErrorBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class RadiosListFullBody extends StatelessWidget {
  final RadiosListViewModel viewModel;
  const RadiosListFullBody(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radiosList = viewModel.radiosList;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('RadioTunes'),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView.builder(
          itemBuilder: (context, index) => RadiosListElement(radiosList[index]),
          itemCount: radiosList.length,
        ),
      ),
    );
  }
}

class RadiosListElement extends StatelessWidget {
  final RadioStation radio;
  const RadiosListElement(this.radio, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioIcon(radio),
                    const Gap(8),
                    Text(
                      radio.name,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const Gap(8),
                    Text(
                      radio.formattedTags,
                      style: TextStyle(color: Colors.white.withOpacity(.4), fontSize: 14),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.foregroundColor,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    size: 20,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RadioIcon extends StatelessWidget {
  final RadioStation radio;
  const RadioIcon(this.radio, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 40,
      width: 40,
      child: radio.icon.isEmpty
          ? const Icon(Icons.radio, color: AppColors.backgroundColor)
          : CachedNetworkImage(imageUrl: radio.icon),
    );
  }
}
