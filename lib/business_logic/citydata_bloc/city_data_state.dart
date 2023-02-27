part of 'city_data_bloc.dart';

@immutable
abstract class CityDataState {}

class DatabaseInitial extends CityDataState {}

class DatabaseLoading extends CityDataState {}

class DatabaseLoaded extends CityDataState {}

class DatabaseError extends CityDataState {}
