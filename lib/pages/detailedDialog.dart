import 'package:converter/converter.dart';
import 'package:flutter/material.dart';

import 'package:weather_app/users.dart';

class DetailedDialog {
  static final DetailedDialog _instance = DetailedDialog._internal();

  factory DetailedDialog() {
    return _instance;
  }

  DetailedDialog._internal();

  Future<void> buildDetailedDialog(BuildContext context,
      AsyncSnapshot<Map<String, dynamic>> snapshot, Size size) {
    print(snapshot);
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          final size = MediaQuery.of(context).size;
          int temp = Temperature(
              snapshot.data!['main']['temp'], 'K')
              .valueIn('C')
              .round();
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            insetPadding: EdgeInsets.only(top: size.height*0.04, bottom: size.height*0.4),
            content: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: size.width * 0.25,
                        height: size.height * 0.04,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2.5),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            "Close",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    UserInfo().getCity(),
                    style: const TextStyle(fontSize: 28),
                  ),
                  Text(
                    // this is OK because all Dart integers are 64 bit
                      '${DateTime.fromMillisecondsSinceEpoch(snapshot.data!['dt'] * 1000)}'.substring(0, 19)
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text( // Temperature
                    'Temperature: ${temp} °C',
                    style: const TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text( // General description
                    'Conditions: ${snapshot.data?['weather'][0]['description']!}'
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text( // Humidity
                    'Humidity: ${snapshot.data?['main']['humidity']}%'
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text( // Wind
                    'Wind: ${(snapshot.data?['wind']['speed'] * 3.6).toStringAsFixed(0)}kmh @ ${snapshot.data?['wind']['deg']}°'
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text( // Visibility
                    'Visibility: ${snapshot.data?['visibility'] == 10000 ? "Far" : snapshot.data?['visibility']}'
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  const Text( // UV
                    'UV: 3-Low'
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text('Air quality: 3-Low'),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Text('Outfit'),
                      SizedBox(width: size.width * 0.08,),
                      Image.asset(UserInfo().outfitChoose(temp))
                    ],
                  ), // Air quality
                ]
            ),
          );
        }
    );
  }
}