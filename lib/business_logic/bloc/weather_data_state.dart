part of 'weather_data_bloc.dart';

@immutable
abstract class WeatherDataState {}

class DataInitial extends WeatherDataState {}

class DataLoaded extends WeatherDataState {}

class DataLoading extends WeatherDataState {}

class LocPermission extends WeatherDataState {}

class LocManualGuide extends WeatherDataState {}

class DataError extends WeatherDataState {
  final String msg;

  DataError({required this.msg});
}
