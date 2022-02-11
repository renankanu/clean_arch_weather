import 'package:clean_arch_weather/core/errors/failure.dart';
import 'package:clean_arch_weather/features/city_weather/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String city);
}
