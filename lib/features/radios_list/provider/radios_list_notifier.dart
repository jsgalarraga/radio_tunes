import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_app/data/repositories/http_radios.dart';
import 'package:radio_app/features/radios_list/model/radios_list_view_model.dart';

class RadiosListNotifier extends StateNotifier<RadiosListBaseModel> {
  RadiosListNotifier() : super(Loading());

  void fetch() async {
    final radiosList = await HttpRadiosRepository().getAllRadioStations();

    state = RadiosListViewModel(radiosList);
  }
}
