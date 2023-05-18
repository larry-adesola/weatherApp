import 'dart:convert';
import 'package:converter/converter.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/data.dart';
import 'package:weather_app/users.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Future<Map<String, dynamic>> _getWeather() async {
    final apiKey = UserInfo().getAPIkey();
    final encodedCityName = Uri.encodeComponent(UserInfo().getCity());
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$encodedCityName&appid=$apiKey';
    print(url);
    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    print(decodedResponse);
    if (response.statusCode == 200) {
      return decodedResponse;
    }
    else {
      throw Exception('Failed to fetch weather data');
    }
  }
  Future<Map<String, dynamic>> _getForecast() async {
    final apiKey = UserInfo().getAPIkey();
    final encodedCityName = Uri.encodeComponent(UserInfo().getCity());
    final url = 'https://api.openweathermap.org/data/2.5/forecast?q=$encodedCityName&appid=$apiKey';
    print(url);
    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    print(decodedResponse);
    if (response.statusCode == 200) {
      return decodedResponse;
    }
    else {
      throw Exception('Failed to fetch weather data');
    }
  }
  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
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
          UserInfo().getCity(),
          style: const TextStyle(fontSize: 35),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        FutureBuilder(
          future: _getWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Lottie.asset('assets/anims/loading.json'),
                  const Text('Loading')
                ],
              );
            }
            else if (snapshot.connectionState == ConnectionState.none) {
              return const Text('Go To Settings and Enter City Properly');
            }
            else {
              return Container(
                width: size.width*0.9,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.5),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    SizedBox(height: size.height*0.025,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                                width: size.width * 0.4,
                                child: Image.asset(
                                    WeatherData().weatherIcons[snapshot.data?['weather'][0]['main']]!
                                )
                            ),
                            SizedBox(height: size.height*0.01,),
                            Text(snapshot.data?['weather'][0]['description']!)
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Current', style: TextStyle(fontSize: 30),),
                            SizedBox(height: size.height*0.01,),
                            Text('${Temperature(snapshot.data!['main']['temp'], 'K').valueIn('C').round()} °C', style: const TextStyle(fontSize: 28),),
                            SizedBox(height: size.height*0.01,),
                            Text('${DateTime.now().hour}:${_twoDigits(DateTime.now().minute)}')
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: size.height*0.025,),
                  ],
                ),
              );
            }
          },
        ),
        SizedBox(height: size.height*0.05,),
        Padding(
          padding:  EdgeInsets.only(left: size.width*0.06),
          child: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Your Times',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),

      ]),
    );
  }
}
