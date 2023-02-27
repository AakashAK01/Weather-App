part of 'city_data_bloc.dart';

@immutable
abstract class CityDataEvent {}

class InsertDb extends CityDataEvent {
  final String cityName;
  InsertDb({required this.cityName});
}

class DeleteDb extends CityDataEvent {
  final int cityId;
  DeleteDb({required this.cityId});
}
