import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app_latest/constants/app_constants.dart';
import 'package:weather_app_latest/data/weather_data_model/weather_data_model.dart';

import '../../data/database/app_database.dart';
import '../../logger.dart';

part 'city_data_event.dart';
part 'city_data_state.dart';

class CityDataBloc extends Bloc<CityDataEvent, CityDataState> {
  WeatherDataModel? weatherDataModel;
  List<Map<String, dynamic>> cityList = [];
  CityDataBloc() : super(DatabaseLoading()) {
    on<InsertDb>(_insertLogic);
    on<DeleteDb>(_deleteLogic);
  }
  void init() async {
    logger.i("Entered INIT");
    emit(DatabaseLoading());
    final data = await CityDatabaseHelper.getCities();
    cityList = data;
    logger.i(cityList.length);
    if (data.isNotEmpty) {
      emit(DatabaseLoaded());
    }
  }

  _insertLogic(InsertDb event, Emitter<CityDataState> emit) async {
    await CityDatabaseHelper.createCity(event.cityName);
    logger.i(event.cityName);
    logger.i("...TOTAL${cityList.length}");
  }

  _deleteLogic(DeleteDb event, Emitter<CityDataState> emit) async {}
}
