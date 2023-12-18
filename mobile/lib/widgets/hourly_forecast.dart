import 'package:flutter/material.dart';
import 'package:mobile/data/core/models/colors.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({ Key? key }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: WAColors.primaryColor),
      child: ListView(
       scrollDirection: Axis.vertical,
       children: const [
        Column(
          children: [
            Text("9\u2301")
          ],
        )
       ],
      ),
    );
  }
}