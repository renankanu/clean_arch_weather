import 'package:bloc/bloc.dart';
import 'package:clean_arch_weather/features/city_weather/domain/usecases/get_current_weather.dart';
import 'package:clean_arch_weather/features/city_weather/presentation/bloc/weather_event.dart';
import 'package:clean_arch_weather/features/city_weather/presentation/bloc/weather_state.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._getCurrentWeather) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        final cityName = event.cityName;

        emit(WeatherLoading());

        final result = await _getCurrentWeather(cityName);

        result.fold(
          (failure) => emit(WeatherError(failure.message)),
          (data) => emit(WeatherHasData(data)),
        );
      },
      transformer: debounce(Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  final GetCurrentWeather _getCurrentWeather;
}
