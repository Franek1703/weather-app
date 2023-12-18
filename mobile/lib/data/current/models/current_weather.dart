import 'dart:convert';

import 'package:collection/collection.dart';

class CurrentWeather {
  final int? lastUpdatedEpoch;
  final double? temperatureCelsius;
  final double? temperatureFahrenheit;
  final double? windMph;
  final double? windKph;
  final String? windDirection;
  final int? humidity;
  final int? cloudiness;
  final double? uv;
  final double? fellTemperatureCelcius;
  final String? conditionText;
  final String? conditionIcon;
  final int? windDegree;
  final double? pressure;
  CurrentWeather({
    this.lastUpdatedEpoch,
    this.temperatureCelsius,
    this.temperatureFahrenheit,
    this.windMph,
    this.windKph,
    this.windDirection,
    this.humidity,
    this.cloudiness,
    this.uv,
    this.fellTemperatureCelcius,
    this.conditionText,
    this.conditionIcon,
    this.windDegree,
    this.pressure
  });

  CurrentWeather copyWith({
    int? lastUpdatedEpoch,
    double? temperatureCelsius,
    double? temperatureFahrenheit,
    double? windMph,
    double? windKph,
    String? windDirection,
    int? humidity,
    int? cloudiness,
    double? uv,
    double? fellTemperatureCelcius,
    String? conditionText,
    String? conditionIcon,
    int? windDegree,
    double? pressure
  }) {
    return CurrentWeather(
      lastUpdatedEpoch: lastUpdatedEpoch ?? this.lastUpdatedEpoch,
      temperatureCelsius: temperatureCelsius ?? this.temperatureCelsius,
      temperatureFahrenheit: temperatureFahrenheit ?? this.temperatureFahrenheit,
      windMph: windMph ?? this.windMph,
      windKph: windKph ?? this.windKph,
      windDirection: windDirection ?? this.windDirection,
      humidity: humidity ?? this.humidity,
      cloudiness: cloudiness ?? this.cloudiness,
      uv: uv ?? this.uv,
      fellTemperatureCelcius: fellTemperatureCelcius?? this.fellTemperatureCelcius,
      conditionText: conditionText?? this.conditionText,
      conditionIcon: conditionIcon?? this.conditionIcon,
      windDegree: windDegree?? this.windDegree,
      pressure: pressure ?? this.pressure,
    );
  }

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      lastUpdatedEpoch: json['current']['last_updated_epoch'],
      temperatureCelsius: json['current']['temp_c'],
      temperatureFahrenheit: json['current']['temp_f'],
      windMph: json['current']['wind_mph'],
      windKph: json['current']['wind_kph'],
      windDirection: json['current']['wind_dir'],
      humidity: json['current']['humidity'],
      cloudiness: json['current']['cloud'],
      uv: json['current']['uv'],
      fellTemperatureCelcius: json['current']['feelslike_c'],
      conditionText: json['current']['condition']['text'],
      conditionIcon: json['current']['condition']['icon'],
      windDegree: json['current']['wind_degree'],
      pressure: json['current']['pressure_mb'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'last_updated_epoch': lastUpdatedEpoch,
      'temp_c': temperatureCelsius,
      'temp_f': temperatureFahrenheit,
      'wind_mph': windMph,
      'wind_kph': windKph,
      'wind_dir': windDirection,
      'humidity': humidity,
      'cloud': cloudiness,
      'uv': uv,
      'feelslike_c': fellTemperatureCelcius,
      //'condition': condition.map((x) => x.toMap()).toList(),
    };
  }


  String toJson() => json.encode(toMap());

  //factory CurrentWeather.fromJson(String source) => CurrentWeather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CurrentWeather(lastUpdatedEpoch: $lastUpdatedEpoch, temperatureCelsius: $temperatureCelsius, temperatureFahrenheit: $temperatureFahrenheit, windMph: $windMph, windKph: $windKph, windDirection: $windDirection, humidity: $humidity, cloudiness: $cloudiness, uv: $uv, fellTemperatureCelcius: $fellTemperatureCelcius, conditionText: $conditionText, conditionIcon: $conditionIcon, windDegree: $windDegree, pressure: $pressure,)';
  }

  @override
  bool operator ==(covariant CurrentWeather other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.lastUpdatedEpoch == lastUpdatedEpoch &&
      other.temperatureCelsius == temperatureCelsius &&
      other.temperatureFahrenheit == temperatureFahrenheit &&
      other.windMph == windMph &&
      other.windKph == windKph &&
      other.windDirection == windDirection &&
      other.humidity == humidity &&
      other.cloudiness == cloudiness &&
      other.uv == uv &&
      other.fellTemperatureCelcius == fellTemperatureCelcius&&
      other.conditionText == conditionText&&
      other.conditionIcon == conditionIcon&&
      other.windDegree == windDegree;
  }

  @override
  int get hashCode {
    return lastUpdatedEpoch.hashCode ^
      temperatureCelsius.hashCode ^
      temperatureFahrenheit.hashCode ^
      windMph.hashCode ^
      windKph.hashCode ^
      windDirection.hashCode ^
      humidity.hashCode ^
      cloudiness.hashCode ^
      uv.hashCode ^
      fellTemperatureCelcius.hashCode^
      conditionText.hashCode^
      conditionIcon.hashCode^
      windDegree.hashCode;
  }
}

/*class Condition {
  final String text;
  final String icon;
  final double code;
  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  Condition copyWith({
    String? text,
    String? icon,
    double? code,
  }) {
    return Condition(
      text: text ?? this.text,
      icon: icon ?? this.icon,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'icon': icon,
      'code': code,
    };
  }

  factory Condition.fromMap(Map<String, dynamic> map) {
    return Condition(
      text: map['text'] ?? '',
      icon: map['icon'] ?? '',
      code: map['code']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Condition.fromJson(String source) => Condition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Condition(text: $text, icon: $icon, code: $code)';

  @override
  bool operator ==(covariant Condition other) {
    if (identical(this, other)) return true;
  
    return 
      other.text == text &&
      other.icon == icon &&
      other.code == code;
  }

  @override
  int get hashCode => text.hashCode ^ icon.hashCode ^ code.hashCode;
}*/
