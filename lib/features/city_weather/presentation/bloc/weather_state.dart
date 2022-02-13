import 'package:clean_arch_weather/features/city_weather/domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherEmpty extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherError extends WeatherState {
  WeatherError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class WeatherHasData extends WeatherState {
  WeatherHasData(this.weather);

  final Weather weather;

  @override
  List<Object> get props => [weather];
}
