import 'dart:convert';
import 'package:converter/converter.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/pages/homeBase.dart';
import 'package:weather_app/users.dart';

class MainScreen extends StatefulWidget {
  UserInfo userInfo;
  MainScreen({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Map<String, String> weatherIcons = {'Clouds': 'assets/icons/clouds.png'};

  Future<Map<String, dynamic>> getWeather() async {
    const apiKey = '3194812ebdac044591796f914fbabf78';
    final encodedCityName = Uri.encodeComponent(widget.userInfo.cityName);
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$encodedCityName&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    print(response);
    final decodedResponse = jsonDecode(response.body);
    print(decodedResponse);
    if (response.statusCode == 200) {
      return decodedResponse;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(children: [
        SizedBox(
          height: size.height * 0.1,
        ),
        Text(
          widget.userInfo.cityName,
          style: TextStyle(fontSize: 35),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        FutureBuilder(
          future: getWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Lottie.asset('assets/anims/loading.json'),
                  Text('Loading')
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text('Go To Settings and Enter City Properly');
            } else {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                              width: size.width * 0.4,
                              child: Image.asset(
                                  weatherIcons[snapshot.data?['weather'][0]['main']]!)),
                          SizedBox(height: size.height*0.01,),
                          Text(snapshot.data?['weather'][0]['description']!)
                        ],
                      ),
                      Column(
                        children: [
                          Text('Current', style: TextStyle(fontSize: 25),),
                          SizedBox(height: size.height*0.01,),
                          Text('${Temperature(snapshot.data!['main']['temp'], 'K').valueIn('C').round()} °C', style: TextStyle(fontSize: 25),)
                        ],
                      )
                    ],
                  )
                ],
              );
            }
          },
        )
      ]),
    );
  }
}
