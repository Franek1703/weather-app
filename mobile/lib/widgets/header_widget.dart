import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/core/geolocator.dart';
import 'package:mobile/data/core/models/colors.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({ Key? key }) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String subplace = "";
   final GlobalControler globalControler = Get.put(GlobalControler(), permanent: true);
  @override
   void initState() {
    city = globalControler.getCity().value;
    subplace = globalControler.getSubplace().value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20,top: 10),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15, right: 15),
          height: 50,

          width: double.infinity,
          decoration: BoxDecoration(color: WAColors.primaryColor,
          borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              const Icon(
              Icons.location_on_outlined,
              size: 30,
            ),
            SizedBox(width: 10,),
              Text('$city, $subplace',
              style: const TextStyle(
                fontSize: 30
              ),),
            ],
          ),
          
        ),
      ],
    );
  }
}