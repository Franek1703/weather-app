import 'package:mobile/api/api_key.dart';

enum WeatherClientPath{
  current,
  forecast;

  const WeatherClientPath();

  String get path {
    switch (this) {
      case WeatherClientPath.current:
        return '/v1/current.json';
      case WeatherClientPath.forecast:
        return '/v1/forecast.json';
    }
  }

  Uri get baseUri => Uri(
        scheme: 'http',
        host: 'api.weatherapi.com',
        path: '',
         queryParameters:  {
          'key': tmdbApiKey,
        }
    );

    Uri getUri([String? query]){
      if (query == null) {
        return baseUri;
      }
       return Uri(
        scheme: 'http',
        host: 'api.weatherapi.com',
        path: path,
         queryParameters:  {
          'key': tmdbApiKey,
          'q': query,
        }
    );

    }

}