import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:radio_app/domain/entities/radio_station.dart';
import 'package:radio_app/domain/provider/providers.dart';
import 'package:radio_app/features/radios_list/model/radios_list_view_model.dart';

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
      body: ListView.separated(
        itemBuilder: (context, index) => RadiosListElement(radiosList[index]),
        separatorBuilder: (context, index) => const Gap(16),
        itemCount: radiosList.length,
      ),
    );
  }
}

class RadiosListElement extends StatelessWidget {
  final RadioStation radio;
  const RadiosListElement(this.radio, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${radio.name} - ${radio.popularity} - ${radio.votes} - ${radio.available}',
    );
  }
}
