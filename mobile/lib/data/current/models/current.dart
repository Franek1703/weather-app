
import 'dart:convert';

import 'package:mobile/data/core/wather_client.dart';
import 'package:mobile/data/current/models/current_weather.dart';
import 'package:mobile/data/current/models/location.dart';

class CurrentWeatherRepository {
  Future<CurrentWeather> getCurrentWeather(String location) async {
    WeatherClient client = WeatherClient();
    final response = await client.getCurrent(location);
    final Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return CurrentWeather.fromJson(body);
    } else {
      throw Exception("Failed to load API");
    }
  }
}


/*class Current {
  final Location? location;
  final CurrentWeather? current;

  Current({
    this.location,
    this.current,
  });

  Current copyWith({
    Location? location,
    CurrentWeather? current,
  }) {
    return Current(
      location: location ?? this.location,
      current: current ?? this.current,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location?.toMap(),
      'current': current?.toMap(),
    };
  }

  factory Current.fromMap(Map<String, dynamic> map) {
    return Current(
      location: Location.fromMap(map['location']),
      current: CurrentWeather.fromMap(map['current']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Current.fromJson(String source) => Current.fromMap(json.decode(source));

  @override
  String toString() => 'Current(current: $current)';//'Current(location: $location, current: $current)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Current &&
      other.location == location &&
      other.current == current;
  }

  @override
  int get hashCode => current.hashCode;
}*/