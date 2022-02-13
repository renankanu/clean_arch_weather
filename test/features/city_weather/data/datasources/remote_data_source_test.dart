import 'dart:convert';

import 'package:clean_arch_weather/core/errors/exception.dart';
import 'package:clean_arch_weather/features/city_weather/data/datasources/remote_data_source.dart';
import 'package:clean_arch_weather/features/city_weather/data/models/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late RemoteDataSourceImpl remoteDataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    remoteDataSource = RemoteDataSourceImpl(dioClient: mockDio);
  });

  group('get current weather', () {
    final tCityName = 'Cianorte';
    final tJson = json.decode(fixture('weather_model.json'));
    final tWeatherModel = WeatherModel.fromJson(tJson);

    test('should return weather model when the response code is 200', () async {
      // arrange
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: tJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // act
      final result = await remoteDataSource.getCurrentWeather(tCityName);

      // assert
      expect(result, equals(tWeatherModel));
    });

    test(
        'should throw a server exception when the response code is 404 or other',
        () async {
      //arrange
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // act
      final call = remoteDataSource.getCurrentWeather(tCityName);

      // assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
}
