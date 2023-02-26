import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../data/weather_data_model/weather_data_model.dart';
import '../faliure_success.dart';
import '../logger.dart';

class WeatherRepo {
  final _apiKey = "4ac3143747454d40886100725221807";
  late Dio _dioClient;
  WeatherDataModel? weatherData;
  WeatherRepo() {
    _dioClient = Dio();
  }
  Future<Either<Failure, Success>> getAllCurrentWeatherDetails(city) async {
    try {
      var _apiUrl =
          "http://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$city&aqi=no";
      var res = await _dioClient.get(_apiUrl);
      //logger.i(res.data);

      weatherData = WeatherDataModel.fromJson(res.data);

      return Right(Success());
    } on DioError catch (e) {
      logger.e(e.response, StackTrace.current);

      return Left(Failure(e.response?.data['error']['message']));
    }
  }
}
