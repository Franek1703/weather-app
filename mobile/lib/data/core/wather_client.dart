import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/data/core/base_client.dart';
import 'package:mobile/data/core/wather_client_path.dart';
import 'package:mobile/data/core/geolocator.dart';
import 'package:mobile/data/core/weather_data.dart';
import 'package:mobile/data/current/models/current.dart';
import 'package:mobile/data/current/models/current_weather.dart';

class WeatherClient extends WABaseClient {
  Future<dynamic> getCurrent(String location)  async{
    final response = await get(WeatherClientPath.current.getUri(location));//globalControler.getCity().value));
    //var jsonString = jsonDecode(response.body);
    //weatherData = WeatherData(WeatherDataCurrent.fromMap(jsonString));
   //return weatherData!;
   return response;
  }

  Future<void> getForecast() async {
    final response = await get(WeatherClientPath.forecast.getUri());


    return;
  }
}

