import 'package:flutter/material.dart';
import 'package:mobile/data/core/geolocator.dart';
import 'package:mobile/data/core/wather_client.dart';
import 'package:mobile/data/current/models/current.dart';
import 'package:mobile/data/current/models/current_weather.dart';
import 'package:mobile/presentation/home_screen.dart';
import 'package:get/get.dart';


void main() async {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  
  const MyApp({super.key,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Weather',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

