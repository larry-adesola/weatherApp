import 'package:flutter/material.dart';
import 'package:weather_app/users.dart';

class DetailedDialog {
  static final DetailedDialog _instance = DetailedDialog._internal();

  factory DetailedDialog() {
    return _instance;
  }

  DetailedDialog._internal();

  Future<void> buildDetailedDialog(BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot, Size size) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          final size = MediaQuery.of(context).size;
          Map<String, dynamic> data = snapshot.data!;
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            insetPadding: EdgeInsets.only(top: size.height * 0.04, bottom: size.height * 0.2),
            content: Column(children: [
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
                        border: Border.all(color: Colors.black, width: 2.5), borderRadius: BorderRadius.circular(12)),
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
              Text(UserInfo().getLocation(), style: const TextStyle(fontSize: 28)),
              Text('${DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000)}'.substring(0, 19)),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text('Temperature: ${data['main']['temp'].round()} °C', style: const TextStyle(fontSize: 25)),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text('Feels Like: ${data['main']['feels_like'].round()} °C'),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text('Conditions: ${data['weather'][0]['description']!}'),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text('Humidity: ${data['main']['humidity']}%'),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text('Wind: ${(data['wind']['speed'] * 3.6).toStringAsFixed(0)}kmh'),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text('Visibility: ${data['visibility'] == 10000 ? "Far" : data['visibility']}'),
              SizedBox(
                height: size.height * 0.01,
              ),
              const Text('UV: 3-low'),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Outfit'),
                  SizedBox(
                    width: size.width * 0.08,
                  ),
                  Image.asset(UserInfo().outfitChoose(data['main']['temp']))
                ],
              ), // Air quality
            ]),
          );
        });
  }
}
