import 'package:clean_arch_weather/core/constants/urls_constant.dart';
import 'package:clean_arch_weather/features/city_weather/presentation/bloc/weather_bloc.dart';
import 'package:clean_arch_weather/features/city_weather/presentation/bloc/weather_event.dart';
import 'package:clean_arch_weather/features/city_weather/presentation/bloc/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Weather',
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter city name',
              ),
              onSubmitted: (query) {
                context.read<WeatherBloc>().add(OnCityChanged(query));
              },
            ),
            SizedBox(height: 32.0),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is WeatherHasData) {
                  return Column(
                    key: Key('weather_data'),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.weather.cityName,
                            style: TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                          Image(
                            image: NetworkImage(
                              Urls.weatherIcon(
                                state.weather.iconCode,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '${state.weather.main} | ${state.weather.description}',
                        style: TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Table(
                        defaultColumnWidth: FixedColumnWidth(150.0),
                        border: TableBorder.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Temperature',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.weather.temperature.toString(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ), // Will be change later
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Pressure',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.weather.pressure.toString(),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold),
                              ),
                            ), // Will be change later
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Humidity',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.weather.humidity.toString(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ), // Will be change later
                          ]),
                        ],
                      ),
                    ],
                  );
                } else if (state is WeatherError) {
                  return Center(
                    key: Key('weather_error'),
                    child: Text('Something went wrong!'),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
