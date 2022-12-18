import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:radio_app/domain/entities/radio_station.dart';
import 'package:radio_app/domain/repositories/abstract_radios.dart';

class HttpRadiosRepository extends AbstractRadiosRepository {
  @override
  Future<List<RadioStation>> getAllRadioStations() async {
    final response = await http.Client().get(
      Uri.https('de1.api.radio-browser.info', 'json/stations'),
    );
    final body = utf8.decode(response.bodyBytes);
    final List list = jsonDecode(body);

    return list.map((e) => RadioStation.fromJson(e)).toList();
  }
}
