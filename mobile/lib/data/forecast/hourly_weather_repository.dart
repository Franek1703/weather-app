import 'package:mobile/data/core/wather_client.dart';
import 'package:mobile/data/forecast/models/hourly_weather.dart';

class HourlyWeatherRepository {
  final WeatherClient client;

  HourlyWeatherRepository({
    required this.client,
  });

  Future<List<HourlyWeather>?> getWeather(String location) async {
    try {
       final model = await client.getHourly(location);

      return model;
    } catch (e) {
      print('EXCEPTION: $e');
    }
    return null;
  }
}