import 'dart:ffi';
import 'dart:math' as math;
import 'package:percent_indicator/percent_indicator.dart';

import 'package:flutter/material.dart';
import 'package:mobile/data/core/models/colors.dart';
import 'package:mobile/data/current/models/current_weather.dart';

class CurrentContainers extends StatelessWidget {
  final CurrentWeather? weatherData;
const CurrentContainers({ Key? key, required this.weatherData }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        Column(
          children: [
            //Wiatr
            Container(
              height: 190,
              width: 180,
              decoration: BoxDecoration(
                color: WAColors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                        "Wind",
                        style:  TextStyle(
                        color: WAColors.primaryTextColor,
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        ),             
                      ),
                      const SizedBox(height: 8,),

                      Text(
                        "${weatherData?.windKph?.round()} km/h",
                        style:  TextStyle(
                        color: WAColors.primaryTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        ),             
                      ),
                      const SizedBox(height: 8,),
                      Center(
                        child: Column(
                          
                          children: [
                            Text("${weatherData?.windDirection}",
                              style:  TextStyle(
                              color: WAColors.primaryTextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              ),
                            ),
                            Transform.rotate(
                              angle: weatherData!.windDegree! * math.pi / 180,
                                child: Icon(Icons.arrow_circle_up_outlined,
                                color: WAColors.iconColor1,
                                size: 70,
                                semanticLabel: "text",),
                            ),
                          ],
                        ),
                      )

                
                  ]),
                ),
            ),
            const SizedBox(height: 20,),
            //Indeks UV
            Container(
              height: 190,
              width: 180,
              decoration: BoxDecoration(
                color: WAColors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                          "UV",
                          style:  TextStyle(
                          color: WAColors.primaryTextColor,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          ),             
                        ),
                        const SizedBox(height: 25,),
                        Text(
                        "${weatherData?.uv?.round()}",
                        style:  TextStyle(
                        color: WAColors.primaryTextColor,
                        fontSize: 40,
                        fontWeight: FontWeight.normal,
                        ),

                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('0'),
                          LinearPercentIndicator(
                            width: 120,
                            lineHeight: 20,
                            percent: weatherData!.uv!.round() / 11,
                            backgroundColor: Colors.greenAccent,
                            progressColor: Colors.green,
                            barRadius: const Radius.circular(10),
                          ),
                          const Text('+11'),
                          
                        ],
                      ),

                      ]
                  ),
                )
            ),

          ],
        ),
        const SizedBox(width: 20,),

        Column(
          children: [
            //Wiatr
            Container(
              height: 190,
              width: 180,
              decoration: BoxDecoration(
                color: WAColors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),),
            ),
            const SizedBox(height: 20,),
            //Indeks UV
            Container(
              height: 190,
              width: 180,
              decoration: BoxDecoration(
                color: WAColors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),),
                child: Padding(
                  padding: EdgeInsets.all(15),

                  child: Row(
                    children: [
                      Column(
                        children: [ 
                          Text(
                              "Pressure",
                              style:  TextStyle(
                              color: WAColors.primaryTextColor,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              ),             
                            ),

                            const SizedBox(height: 25,),
                        Text(
                        "${weatherData?.pressure?.round()}",
                        style:  TextStyle(
                        color: WAColors.primaryTextColor,
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        ),
                        ),
                        Text(
                        "mbar",
                        style:  TextStyle(
                        color: WAColors.secondaryTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        ),
                        ),


                            
                            ],
                        


                      ),
                      Padding(padding: EdgeInsets.only(top: 60, left: 0),
                      child: CircularPercentIndicator(
                        radius: 40,
                        lineWidth: 10,
                        startAngle: 180,
                        percent: weatherData!.pressure! / (1100+900),
                        animation: true,
                        animationDuration: 1200,
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: WAColors.iconColor1,
                        progressColor: Colors.blue,
                        arcType: ArcType.FULL,
                        arcBackgroundColor: WAColors.backgroundColor,
                        
                        
                        


                      ),
                      )
                    ],
                  ),
                
                ),
            ),

          ],
        ),

      ],
    );
  }
}