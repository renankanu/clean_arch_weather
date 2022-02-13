import 'dart:io';

import 'package:clean_arch_weather/core/errors/exception.dart';
import 'package:clean_arch_weather/core/errors/failure.dart';
import 'package:clean_arch_weather/features/city_weather/data/datasources/remote_data_source.dart';
import 'package:clean_arch_weather/features/city_weather/domain/entities/weather.dart';
import 'package:clean_arch_weather/features/city_weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({required this.remoteDataSource});

  final RemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String city) async {
    try {
      final result = await remoteDataSource.getCurrentWeather(city);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
