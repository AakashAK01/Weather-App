import 'package:freezed_annotation/freezed_annotation.dart';

import 'current.dart';
import 'location.dart';

part 'weather_data_model.freezed.dart';
part 'weather_data_model.g.dart';

@freezed
class WeatherDataModel with _$WeatherDataModel {
  factory WeatherDataModel({
    Location? location,
    Current? current,
  }) = _WeatherDataModel;

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataModelFromJson(json);
}
