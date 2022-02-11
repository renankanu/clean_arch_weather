import 'package:clean_arch_weather/features/city_weather/data/datasources/remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late RemoteDataSourceImpl remoteDataSource;
  late MockDio mockDio;

  setUp(() {
    remoteDataSource = RemoteDataSourceImpl(dioClient: mockDio);
    mockDio = MockDio();
  });

  group('get current weather', () {});
}
