import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile/application/core/temperature_value_object.dart';
import 'package:mobile/application/core/wind_value_object.dart';
import 'package:mobile/application/current_weather/current_weather_bloc.dart';
import 'package:mobile/application/current_weather/current_weather_entity.dart';
import 'package:mobile/application/forecast_weather/bloc/forecast_bloc.dart';
import 'package:mobile/application/forecast_weather/forecast_weather_entity.dart';
import 'package:mobile/application/forecast_weather/hourly_weather_entity.dart';
import 'package:mobile/data/core/geolocator.dart';
import 'package:mobile/data/core/models/colors.dart';
import 'package:mobile/data/core/wather_client.dart';
import 'package:mobile/data/current/current_weather_repository.dart';
import 'package:mobile/data/forecast/forecast_weather_repository.dart';
import 'package:mobile/data/forecast/hourly_weather_repository.dart';
import 'package:get/get.dart';
import 'package:mobile/widgets/current_containers.dart';
import 'package:mobile/widgets/current_temp.dart';
import 'package:mobile/widgets/forecast.dart';
import 'package:mobile/widgets/hourly_forecast.dart';
import 'package:mobile/widgets/test.dart';
import 'package:provider/provider.dart';

void main() async {
   final forecast = await WeatherClient().getForecast("Warsaw");
   print(forecast);
  runApp(
    Provider(
      create: (context) => WeatherClient(),
      child: Provider(
        create: (context) => CurrentWeatherRepository(
          client: context.read<WeatherClient>(),
        ),
        child: Provider(
          create: (context) => ForecastWeatherRepository(
            client: context.read<WeatherClient>(),
          ),
          child: Provider(
            create: (context) => HourlyWeatherRepository(
              client: context.read<WeatherClient>(),
            ),
            child: const MainApp(),
          ),
        ),
      ),
    ),
  );
  // final weather = ForecastBloc(
  //     repository: ForecastWeatherRepository(client: WeatherClient()),
  //     repositoryHourly: HourlyWeatherRepository(client: WeatherClient()));
  // weather.add(ForecastEvent(location: "Warsaw"));
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  CurrentWeatherEntity? getWeather({required CurrentWeatherState from}) {
    final state = from;

    if (state is CurrentWeatherLoading) {
      return state.lastWeather;
    }

    if (state is CurrentWeatherLoaded) {
      return state.weather;
    }

    return null;
  }

  List<ForecastWeatherEntity>? getForecastWeather(
      {required ForecastWeatherState from}) {
    final state = from;

    if (state is ForecastWeatherLoading) {
      return state.lastWeather;
    }

    if (state is ForecastWeatherLoaded) {
      return state.weather;
    }

    return null;
  }

  List<HourlyWeatherEntity>? getHourlytWeather(
      {required ForecastWeatherState from}) {
    final state = from;

    if (state is ForecastWeatherLoading) {
      return state.lastHourly;
    }

    if (state is ForecastWeatherLoaded) {
      return state.hourly;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
    final GlobalControler globalControler =
        Get.put(GlobalControler(), permanent: true);
    var isLocationTrue = useState(true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: _determinePosition(),
          builder: (context, snap) {
            if (snap.hasData) {
              if (isLocationTrue.value) {
                textEditingController.text = globalControler.getCity().value;
                print(globalControler.getCity().value);
              }
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => CurrentWeatherBloc(
                      repository: context.read<CurrentWeatherRepository>(),
                    )..add(
                        QueryForLocationEvent(location: snap.requireData),
                      ),
                  ),
                  BlocProvider(
                      create: (contextForecast) => ForecastBloc(
                          repository:
                              contextForecast.read<ForecastWeatherRepository>(),
                          repositoryHourly:
                              contextForecast.read<HourlyWeatherRepository>())
                        ..add(
                          ForecastEvent(location: snap.requireData),
                        ),
                  ),
                ],
                child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
                    builder: (context, state) {
                  final weather = getWeather(from: state);

                  
                      return BlocBuilder<ForecastBloc, ForecastWeatherState>(
                        builder: (contextForecast, stateForecast) {
                          final forecast =
                              getForecastWeather(from: stateForecast);
                          
                          final hourly = getHourlytWeather(from: stateForecast);
                          
                         
                            return Scaffold(
                              extendBodyBehindAppBar: true,
                              appBar: AppBar(
                                backgroundColor: Colors.transparent,
                                // elevation: 0,
                                systemOverlayStyle: const SystemUiOverlayStyle(
                                    statusBarBrightness: Brightness.dark),
                              ),
                              backgroundColor: WAColors.backgroundColor,
                              body: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0, 1.2 * kToolbarHeight, 0, 20),
                                // child: Obx(
                                //   () => globalControler.checkLoading().isTrue
                                //       ? const Center(child: CircularProgressIndicator()):
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(3, -0.3),
                                        child: Container(
                                          height: 300,
                                          width: 300,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.deepPurple),
                                        ),
                                      ),
                                      Align(
                                        alignment: const AlignmentDirectional(
                                            -3, -0.3),
                                        child: Container(
                                          height: 300,
                                          width: 300,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF673AB7)),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0, -1.2),
                                        child: Container(
                                          height: 300,
                                          width: 600,
                                          decoration: const BoxDecoration(
                                              color: Color(0xFFFFAB40)),
                                        ),
                                      ),
                                      BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 100.0, sigmaY: 100.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.transparent),
                                        ),
                                      ),
                                      
                                      SingleChildScrollView(
                                        child: Column(
                                          // mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20, right: 20, top: 0),
                                              alignment: Alignment.centerLeft,
                                              padding: isLocationTrue.value
                                                  ? const EdgeInsets.only(
                                                      left: 15, right: 15)
                                                  : const EdgeInsets.only(
                                                      left: 9, right: 15),
                                              height: 50,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: WAColors.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Row(
                                                children: [
                                                  if (isLocationTrue.value) ...[
                                                    const Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 30,
                                                    ),
                                                  ],
                                                  if (isLocationTrue.value ==
                                                      false) ...[
                                                    IconButton(
                                                      onPressed: () {
                                                        textEditingController
                                                                .text =
                                                            globalControler
                                                                .getCity()
                                                                .value;
                                                        isLocationTrue.value =
                                                            true;
                                                        context
                                                            .read<
                                                                CurrentWeatherBloc>()
                                                            .add(
                                                              QueryForLocationEvent(
                                                                  location: snap
                                                                      .requireData),
                                                            );
                                                        contextForecast
                                                            .read<
                                                                ForecastBloc>()
                                                            .add(
                                                              ForecastEvent(
                                                                  location: snap
                                                                      .requireData),
                                                            );
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .location_off_outlined,
                                                        size: 28,
                                                      ),
                                                    ),
                                                  ],
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          textEditingController,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      if (textEditingController
                                                              .text !=
                                                          snap.requireData) {
                                                        final location =
                                                            textEditingController
                                                                .text;
                                                        isLocationTrue.value =
                                                            false;

                                                        context
                                                            .read<
                                                                CurrentWeatherBloc>()
                                                            .add(
                                                              QueryForLocationEvent(
                                                                  location:
                                                                      location),
                                                            );
                                                        contextForecast
                                                            .read<
                                                                ForecastBloc>()
                                                            .add(
                                                              ForecastEvent(
                                                                  location:
                                                                      location),
                                                            );
                                                      }
                                                    },
                                                    icon: const Icon(
                                                        Icons.search),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            CurrentTemp(
                                                temperature: weather
                                                        ?.temperatureC ??
                                                    const TemperatureValueObject(
                                                        value: 0,
                                                        unit: TemperatureUnit
                                                            .celsius),
                                                icon: weather?.conditionIcon ??
                                                    '//cdn.weatherapi.com/weather/64x64/day/302.png',
                                                conditionText:
                                                    weather?.conditionText ??
                                                        '',
                                                feelslikeTemperature: weather
                                                        ?.fellTemperatureCelcius ??
                                                    0,
                                                maxTemperature: forecast?[0]
                                                        .maxTemperature ??
                                                    0,
                                                minTemperature: forecast?[0]
                                                        .minTemperature ??
                                                    0),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text("Today",
                                                //textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: WAColors
                                                        .primaryTextColor,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            HourlyForecast(
                                                hourly: hourly ?? []),
                                            const SizedBox(
                                              height: 20,
                                            ),

                                            Text("Forecast",
                                                //textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: WAColors
                                                        .primaryTextColor,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),

                                            // Forecast(forecast: forecast ?? []),
                                            Forecast(forecast: forecast ?? []),

                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text("Current weather",
                                                  //textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: WAColors
                                                          .primaryTextColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            CurrentContainers(
                                              wind: weather?.windKph ??
                                                  const WindValueObject(
                                                      value: 0,
                                                      unit: WindUnit
                                                          .kilometersPerHour),
                                              pressure: weather?.pressure ?? 0,
                                              uv: weather?.uv ?? 0,
                                              windDegree:
                                                  weather?.windDegree ?? 0,
                                              windDirection:
                                                  weather?.windDirection ?? '',
                                              humidity: weather?.humidity ?? 0,
                                            ),
                                            //  SizedBox(height: 100),
                                            //   Thermometer(
                                            //     temperature: weather?.temperatureC ??
                                            //      const TemperatureValueObject(value: 0, unit:TemperatureUnit.celsius),
                                            //   ),
                                          ],
                                        ),
                                      ),
                                      if (state is CurrentWeatherLoading || stateForecast is ForecastWeatherLoading)
                                        const Center(
                                            child: CircularProgressIndicator()),
                                     
                                      
                                    ],
                                  ),
                                ),
                              ),
                              // ),
                            );
                          // } else {
                          //   return const Center(
                          //       child: CircularProgressIndicator());
                          // }
                        },
                      );
                }),
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<String> _determinePosition() async {
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxString _city = "".obs;
  final RxString _subplace = "".obs;
  final RxInt _currentIndex = 0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _lattitude;
  RxDouble getLongitude() => _longitude;
  RxString getCity() => _city;
  RxString getSubplace() => _subplace;
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
      .then((value) async {
    _lattitude.value = value.latitude;
    _longitude.value = value.longitude;
    List<Placemark> placemark =
        await placemarkFromCoordinates(_lattitude.value, _longitude.value);
    Placemark place = placemark[0];
    _city.value = place.locality!;
    return _city.value;
  });
}
