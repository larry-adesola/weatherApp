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
          return AlertDialog(
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
                      '${DateTime.fromMillisecondsSinceEpoch(snapshot.data!['dt'] * 1000)}'
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text( // Temperature
                    'Temperature: ${Temperature(
                        snapshot.data!['main']['temp'], 'K')
                        .valueIn('C')
                        .round()} °C',
                    style: const TextStyle(fontSize: 28),
                  ),
                  Text( // General description
                    snapshot.data?['weather'][0]['description']!
                  ),
                  Text( // Humidity
                    'Humidity: ${snapshot.data?['main']['humidity']}%'
                  ),
                  Text( // Wind
                    'Wind: ${(snapshot.data?['wind']['speed'] * 3.6).toStringAsFixed(0)}kmh blowing at ${snapshot.data?['wind']['deg']} degrees'
                  ),
                  Text( // Visibility
                    'Visibility: ${snapshot.data?['visibility'] == 10000 ? "Far" : snapshot.data?['visibility']}'
                  ),
                  Text( // UV
                    'UV: ${snapshot.data?['uvi']} is this a separate API call'
                  ),
                  Text('Air quality: is this a separate API call'), // Air quality
                ]
            ),
          );
        }
    );
  }
}