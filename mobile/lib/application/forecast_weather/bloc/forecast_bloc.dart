import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile/application/forecast_weather/forecast_weather_entity.dart';
import 'package:mobile/application/forecast_weather/hourly_weather_entity.dart';
import 'package:mobile/data/forecast/forecast_weather_repository.dart';
import 'package:mobile/data/forecast/hourly_weather_repository.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastWeatherState> {
  final ForecastWeatherRepository repository;
  final HourlyWeatherRepository repositoryHourly;
  ForecastBloc({required this.repository, required this.repositoryHourly}) : super(ForecastWeatherInitial()) {
    on<ForecastEvent>((event, emit) async{
      final location = event.location;
      

      final state = this.state;
      if (state is ForecastWeatherLoaded) {
        emit(ForecastWeatherLoading(lastWeather: state.weather, lastHourly: state.hourly));
      } else {
        emit(ForecastWeatherLoading());
      }

      final weather = await repository.getWeather(location);
      final hourly = await repositoryHourly.getWeather(location);

      if (weather != null) {
        final weatherEntity = weather.map((e) => ForecastWeatherEntity.fromModel(e)).toList();
        final hourlyEntity = hourly?.map((e) => HourlyWeatherEntity.fromModel(e)).toList();
        

        emit(ForecastWeatherLoaded(weather: weatherEntity, hourly:  hourlyEntity));
      } else {
        emit(ForecastWeatherInitial());
      }
    });
  }
}
