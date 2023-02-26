// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WeatherDataModel _$$_WeatherDataModelFromJson(Map<String, dynamic> json) =>
    _$_WeatherDataModel(
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      current: json['current'] == null
          ? null
          : Current.fromJson(json['current'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_WeatherDataModelToJson(_$_WeatherDataModel instance) =>
    <String, dynamic>{
      'location': instance.location,
      'current': instance.current,
    };
