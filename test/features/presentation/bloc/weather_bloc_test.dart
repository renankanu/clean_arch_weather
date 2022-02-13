import 'package:bloc_test/bloc_test.dart';
import 'package:clean_arch_weather/core/errors/failure.dart';
import 'package:clean_arch_weather/features/city_weather/domain/entities/weather.dart';
import 'package:clean_arch_weather/features/city_weather/domain/usecases/get_current_weather.dart';
import 'package:clean_arch_weather/features/city_weather/presentation/bloc/weather_bloc.dart';
import 'package:clean_arch_weather/features/city_weather/presentation/bloc/weather_event.dart';
import 'package:clean_arch_weather/features/city_weather/presentation/bloc/weather_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_bloc_test.mocks.dart';

@GenerateMocks([GetCurrentWeather])
void main() {
  late MockGetCurrentWeather mockGetCurrentWeather;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    weatherBloc = WeatherBloc(mockGetCurrentWeather);
  });

  final tWeather = Weather(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const tCityName = 'Jakarta';

  test('initial state should be empty', () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
    'should emit [loading, has data] when data is gotten successfully',
    build: () {
      when(mockGetCurrentWeather(any)).thenAnswer((_) async => Right(tWeather));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(OnCityChanged(tCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      WeatherHasData(tWeather),
    ],
    verify: (bloc) {
      verify(mockGetCurrentWeather(tCityName));
    },
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [loading, error] when get data is unsuccessful',
    build: () {
      when(mockGetCurrentWeather(tCityName))
          .thenAnswer((_) async => Left(ServerFailure('Server failure')));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(OnCityChanged(tCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      WeatherError('Server failure'),
    ],
    verify: (bloc) {
      verify(mockGetCurrentWeather(tCityName));
    },
  );
}
