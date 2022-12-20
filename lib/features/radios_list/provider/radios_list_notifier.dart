import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_app/data/repositories/http_radios.dart';
import 'package:radio_app/features/radios_list/model/radios_list_view_model.dart';

class RadiosListNotifier extends StateNotifier<RadiosListBaseModel> {
  RadiosListNotifier() : super(Loading());

  void fetch() async {
    try {
      final radiosList = await HttpRadiosRepository().getAllRadioStations();

      radiosList.removeWhere((e) => (e.countryCode != 'ES') || (e.available != 1));
      radiosList.sort((a, b) => b.popularity.compareTo(a.popularity));

      state = RadiosListViewModel(radiosList.sublist(0, 50));
    } catch (_) {
      state = Error();
    }
  }

  void resetAndFetch() {
    state = Loading();
    fetch();
  }
}
