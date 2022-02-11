import 'package:clean_arch_weather/core/errors/failure.dart';
import 'package:clean_arch_weather/features/city_weather/domain/entities/weather.dart';
import 'package:clean_arch_weather/features/city_weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentWeather {
  GetCurrentWeather(this.weatherRepository);

  final WeatherRepository weatherRepository;

  Future<Either<Failure, Weather>> call(String cityName) async {
    return await weatherRepository.getCurrentWeather(cityName);
  }
}
