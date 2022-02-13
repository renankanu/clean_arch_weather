import 'dart:io';

import 'package:clean_arch_weather/core/errors/exception.dart';
import 'package:clean_arch_weather/core/errors/failure.dart';
import 'package:clean_arch_weather/features/city_weather/data/datasources/remote_data_source.dart';
import 'package:clean_arch_weather/features/city_weather/data/models/weather_model.dart';
import 'package:clean_arch_weather/features/city_weather/data/repositories/weather_repository_impl.dart';
import 'package:clean_arch_weather/features/city_weather/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteDataSource])
void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late WeatherRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = WeatherRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

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

  group('get current weather', () {
    final tCityName = 'Jakarta';

    test(
      'should return current weather when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getCurrentWeather(tCityName))
            .thenAnswer((_) async => tWeatherModel);

        // act
        final result = await repository.getCurrentWeather(tCityName);

        // assert
        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(result, equals(Right(tWeather)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getCurrentWeather(tCityName))
            .thenThrow(ServerException());

        // act
        final result = await repository.getCurrentWeather(tCityName);

        // assert
        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getCurrentWeather(tCityName))
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getCurrentWeather(tCityName);

        // assert
        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
}
