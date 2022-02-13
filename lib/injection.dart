import 'package:clean_arch_weather/features/city_weather/data/datasources/remote_data_source.dart';
import 'package:clean_arch_weather/features/city_weather/data/repositories/weather_repository_impl.dart';
import 'package:clean_arch_weather/features/city_weather/domain/repositories/weather_repository.dart';
import 'package:clean_arch_weather/features/city_weather/domain/usecases/get_current_weather.dart';
import 'package:clean_arch_weather/features/city_weather/presentation/bloc/weather_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeather(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      dioClient: locator(),
    ),
  );

  // external
  locator.registerSingleton(Dio());
}
