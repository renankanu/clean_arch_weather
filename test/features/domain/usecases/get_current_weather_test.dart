import 'package:clean_arch_weather/features/city_weather/domain/entities/weather.dart';
import 'package:clean_arch_weather/features/city_weather/domain/repositories/weather_repository.dart';
import 'package:clean_arch_weather/features/city_weather/domain/usecases/get_current_weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_current_weather_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeather getCurrentWeather;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeather = GetCurrentWeather(mockWeatherRepository);
  });

  const testWeatherDetail = Weather(
    cityName: 'Cianorte',
    main: 'Clouds',
    description: 'rain',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'Cianorte';
  test('should get current weather detail from the repository', () async {
    //arrange
    when(mockWeatherRepository.getCurrentWeather(testCityName))
        .thenAnswer((_) async => Right(testWeatherDetail));

    //act
    final result = await getCurrentWeather(testCityName);

    //assert
    expect(result, Right(testWeatherDetail));
  });
}
