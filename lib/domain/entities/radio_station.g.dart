// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadioStation _$RadioStationFromJson(Map<String, dynamic> json) => RadioStation(
      json['stationuuid'] as String,
      json['name'] as String,
      json['url'] as String,
      json['url_resolved'] as String,
      json['favicon'] as String,
      json['countrycode'] as String,
      json['lastcheckok'] as int,
      json['votes'] as int,
      json['clickcount'] as int,
    );

Map<String, dynamic> _$RadioStationToJson(RadioStation instance) =>
    <String, dynamic>{
      'stationuuid': instance.id,
      'name': instance.name,
      'url': instance.url,
      'url_resolved': instance.urlResolved,
      'favicon': instance.icon,
      'countrycode': instance.countryCode,
      'lastcheckok': instance.available,
      'votes': instance.votes,
      'clickcount': instance.popularity,
    };
