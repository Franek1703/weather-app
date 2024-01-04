import 'package:flutter/material.dart';
import 'package:mobile/application/core/temperature_value_object.dart';
import 'package:mobile/data/core/models/colors.dart';


class CurrentTemp extends StatelessWidget{
  final TemperatureValueObject temperature;
  final String icon;
  final String conditionText;
  final double feelslikeTemperature;
  final double maxTemperature;
  final double minTemperature;
  const CurrentTemp({ Key? key, 
  required this.temperature,
  required this.icon,
  required this.conditionText,
  required this.feelslikeTemperature,
  required this.maxTemperature,
  required this.minTemperature
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
              "${temperature.value.round()}°C",
              style:  TextStyle(
                color: WAColors.primaryTextColor,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),             
            ),
            //SizedBox(height: 2),
            Text("Max.:${maxTemperature.round()} Min.:${minTemperature.round()}",
             style:  TextStyle(
                color: WAColors.secondaryTextColor,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),),
          ],
        ),
        Image.network("https:$icon"),
        SizedBox(width: 60,),

        Column(
          children: [
              Text(conditionText,
              style:  TextStyle(
                color: WAColors.primaryTextColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
              Text("Feels like: $feelslikeTemperature",
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