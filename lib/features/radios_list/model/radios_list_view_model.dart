import 'package:radio_app/domain/entities/radio_station.dart';

abstract class RadiosListBaseModel {}

class Loading extends RadiosListBaseModel {}

class Error extends RadiosListBaseModel {}

class RadiosListViewModel extends RadiosListBaseModel {
  final List<RadioStation> radiosList;

  RadiosListViewModel(this.radiosList);
}
