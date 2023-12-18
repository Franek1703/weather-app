import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:mobile/data/core/models/colors.dart';
import 'package:mobile/data/core/geolocator.dart';
import 'package:mobile/data/core/wather_client.dart';
import 'package:mobile/data/current/models/current.dart';
import 'package:mobile/data/current/models/current_weather.dart';
import 'package:mobile/widgets/current_containers.dart';
import 'package:mobile/widgets/current_temp.dart';
import 'package:mobile/widgets/header_widget.dart';
import 'package:mobile/widgets/hourly_forecast.dart';
import 'package:mobile/widgets/img.dart';
import 'package:status_bar_control/status_bar_control.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({ Key? key,}) : super(key: key);

  Future<CurrentWeather> getCurrentWeather() async {
    CurrentWeatherRepository currentWeatherRepository =
        CurrentWeatherRepository();
    final data = await currentWeatherRepository.getCurrentWeather("Warszawa");
    print(data);
    return data;
  }

  //Future<Current>  current() async{
  //var currentWeather =  await WeatherClient().getCurrent("Warszawa");
  //return currentWeather;
  //}
  @override
  Widget build(BuildContext context) {
    final GlobalControler globalControler = Get.put(GlobalControler(), permanent: true);
    final future = useMemoized(getCurrentWeather);
    final snapshot = useFuture(future);
    //StatusBarControl.setHidden(false);
    //StatusBarControl.setFullscreen(true);
    //StatusBarControl.setNavigationBarStyle(NavigationBarStyle.DARK);
    return Scaffold(
      backgroundColor: WAColors.backgroundColor,
      body: SafeArea(
        child: Obx(() => globalControler.checkLoading().isTrue ? const Center(
          child: CircularProgressIndicator()
          )
          :ListView(
            scrollDirection: Axis.vertical,
            children:  [
                Stack(
                children: [
                  const Img(),
                  const HeaderWidget(),
                  Positioned(
                    left: 20,
                    top: 80,
                    child:CurrentTemp(weatherClient: snapshot.data)
                    ),
                ],
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("Today",
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: WAColors.primaryTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)
                ),
              ),
              //const HourlyForecast(),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("Current weather",
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: WAColors.primaryTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)
                ),
              ),
              const SizedBox(height: 10,),
              CurrentContainers(weatherData: snapshot.data),

            ],
          )
          ) ),
      
    );
  }
}
