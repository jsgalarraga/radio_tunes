import 'package:radio_app/domain/entities/radio_station.dart';

abstract class RadioPlayerBaseModel {
  final RadioStation? radio;

  RadioPlayerBaseModel(this.radio);
}

class Loading extends RadioPlayerBaseModel {
  Loading(super.radio);
}

class Playing extends RadioPlayerBaseModel {
  Playing(super.radio);
}

class NotPlaying extends RadioPlayerBaseModel {
  NotPlaying(super.radio);

  factory NotPlaying.empty() => NotPlaying(null);
}
