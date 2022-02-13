import 'dart:convert';

import 'package:clean_arch_weather/features/city_weather/data/models/weather_model.dart';
import 'package:clean_arch_weather/features/city_weather/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tWeatherModel = WeatherModel(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  final tWeather = Weather(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  group('to entity', () {
    test('should return a Weather entity', () {
      // act
      final result = tWeatherModel.toEntity();
      // assert
      expect(result, equals(tWeather));
    });
  });

  group('from json', () {
    test('should return a valid model from json', () {
      final tJson = json.decode(fixture('weather_model.json'));
      // act
      final result = WeatherModel.fromJson(tJson);
      // assert
      expect(result, equals(tWeatherModel));
    });
  });

  group('to json', () {
    test('should return a json map containing proper data', () {
      // act
      final result = tWeatherModel.toJson();
      // assert
      final expectedJsonMap = {
        'weather': [
          {
            'main': 'Clouds',
            'description': 'few clouds',
            'icon': '02d',
          }
        ],
        'main': {
          'temp': 302.28,
          'pressure': 1009,
          'humidity': 70,
        },
        'name': 'Jakarta',
      };
      expect(result, equals(expectedJsonMap));
    });
  });
}
