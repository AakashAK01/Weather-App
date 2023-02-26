import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../data/weather_data_model/weather_data_model.dart';
import '../../logger.dart';
import '../../repository/weather_repo.dart';

part 'weather_data_event.dart';
part 'weather_data_state.dart';

class WeatherDataBloc extends Bloc<WeatherDataEvent, WeatherDataState> {
  WeatherDataModel? weatherDataModel;

  String? address;
  WeatherDataBloc() : super(DataLoading()) {
    on<OnSearchClicked>(_searchLogic);
  }
  void init(String city) async {
    emit(DataLoading());
    final _repo = WeatherRepo();

    // else if (_locresult.isPermanentlyDenied) {
    //   emit(LocManualGuide());
    //   return;
    // }

    final result = await _repo.getAllCurrentWeatherDetails(city);
    if (result.isRight()) {
      weatherDataModel = _repo.weatherData;
      print("FROM BLOCCCCCCCCCCCCCCCCCCCCCcc");
      logger.d(weatherDataModel);
      emit(DataLoaded());
    }
  }

  void timer(String city) async {
    final _repo = WeatherRepo();

    final result = await _repo.getAllCurrentWeatherDetails(city);
    if (result.isRight()) {
      emit(DataLoaded());
      weatherDataModel = _repo.weatherData;
      print("FROM TIMER BLOCCCCCCCCCCCCCCCCCCCCCcc");
      logger.d(weatherDataModel);
    }
  }

  _searchLogic(OnSearchClicked event, Emitter<WeatherDataState> emit) async {
    emit(DataLoading());
    final _repo = WeatherRepo();

    final result = await _repo.getAllCurrentWeatherDetails(event.City);
    if (result.isRight()) {
      weatherDataModel = _repo.weatherData;

      print("FROM EVENT BLOCCCCCCCCCCCCCCCCCCCCCcc");
      logger.d(weatherDataModel);
      emit(DataLoaded());
    } else {
      emit(DataError(
        msg: result
            .swap()
            .getOrElse(() => throw UnimplementedError())
            .message
            .toString(),
      ));
    }
  }
}
