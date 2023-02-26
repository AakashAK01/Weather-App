part of 'weather_data_bloc.dart';

@immutable
abstract class WeatherDataEvent {}

class OnSearchClicked extends WeatherDataEvent {
  final String City;
  OnSearchClicked({required this.City});
}
