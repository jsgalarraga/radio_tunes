import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_app/features/radio_player/model/radio_player_view_model.dart';
import 'package:radio_app/features/radio_player/provider/radio_player_notifier.dart';
import 'package:radio_app/features/radios_list/model/radios_list_view_model.dart';
import 'package:radio_app/features/radios_list/provider/radios_list_notifier.dart';

final radiosListProvider = StateNotifierProvider<RadiosListNotifier, RadiosListBaseModel>(
  (ref) => RadiosListNotifier(),
);

final radioPlayerProvider = StateNotifierProvider<RadioPlayerNotifier, RadioPlayerBaseModel>(
  (ref) => RadioPlayerNotifier(),
);
