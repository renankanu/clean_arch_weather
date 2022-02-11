import 'dart:convert';

import 'package:clean_arch_weather/core/constants/urls_constant.dart';
import 'package:clean_arch_weather/core/errors/exception.dart';
import 'package:clean_arch_weather/features/city_weather/data/models/weather_model.dart';
import 'package:dio/dio.dart';

abstract class RemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl({required this.dioClient});

  final Dio dioClient;

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response = await dioClient.get(Urls.currentWeatherByName(cityName));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.data));
    } else {
      throw ServerException();
    }
  }
}
