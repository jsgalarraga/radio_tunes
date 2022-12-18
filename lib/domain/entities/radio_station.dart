import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'radio_station.g.dart';

@immutable
@JsonSerializable()
class RadioStation {
  @JsonKey(name: 'stationuuid')
  final String id;
  final String name;
  final String url;
  @JsonKey(name: 'url_resolved')
  final String urlResolved;
  @JsonKey(name: 'favicon')
  final String icon;

  const RadioStation(
    this.id,
    this.name,
    this.url,
    this.urlResolved,
    this.icon,
  );

  factory RadioStation.fromJson(Map<String, dynamic> json) => _$RadioStationFromJson(json);
}
