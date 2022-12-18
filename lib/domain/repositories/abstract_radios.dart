import 'package:radio_app/domain/entities/radio_station.dart';

abstract class AbstractRadiosRepository {
  Future<List<RadioStation>> getAllRadioStations();
}
