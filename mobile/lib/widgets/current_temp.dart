import 'package:flutter/material.dart';
import 'package:mobile/data/core/models/colors.dart';
import 'package:mobile/data/core/wather_client.dart';
import 'package:mobile/data/current/models/current.dart';
import 'package:mobile/data/current/models/current_weather.dart';

class CurrentTemp extends StatelessWidget{
  final CurrentWeather? weatherClient;

  const CurrentTemp({ Key? key, required this.weatherClient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          
          children: [
             Text(
              'Now',
               style: TextStyle(
                color: WAColors.primaryTextColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${weatherClient?.temperatureCelsius?.round()}\u00BA",
              style:  TextStyle(
                color: WAColors.primaryTextColor,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),             
            ),
            //SizedBox(height: 2),
            Text("Max.:10 Min.:0",
             style:  TextStyle(
                color: WAColors.secondaryTextColor,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),),
          ],
        ),
        Image.network("https:${weatherClient?.conditionIcon}"),
        SizedBox(width: 60,),

        Column(
          children: [
              Text("${weatherClient?.conditionText}",
              style:  TextStyle(
                color: WAColors.primaryTextColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
              Text("Feels like: ${weatherClient?.fellTemperatureCelcius}",
              style:  TextStyle(
                color: WAColors.secondaryTextColor,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),),
              SizedBox(height: 50,)
          ],
          
        )


        
      ],
      
      
    );
  }
}