
import 'package:mobile/data/forecast/models/forecastWeather.dart';
import 'package:mobile/data/forecast/models/hourly_weather.dart';
import 'package:mobile/widgets/hourly_forecast.dart';

class HourlyWeatherEntity{
final double temperature;
final String icon;

  HourlyWeatherEntity({required this.temperature, required this.icon});

   static HourlyWeatherEntity fromModel(HourlyWeather model) {
    return HourlyWeatherEntity(
      temperature: model.temperature,
      icon: model.icon,
      );


   }
}