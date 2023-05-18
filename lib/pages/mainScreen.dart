import 'dart:convert';
import 'package:converter/converter.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/users.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final UserInfo _userInfo = UserInfo.getInstance();
  Map<String, String> weatherIcons = {'Clouds': 'assets/icons/clouds.png'};

  Future<Map<String, dynamic>> getWeather() async {
    final apiKey = _userInfo.getAPIkey();
    final encodedCityName = Uri.encodeComponent(_userInfo.getCity());
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$encodedCityName&appid=$apiKey';
    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return decodedResponse;
    } else {
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
          _userInfo.getCity(),
          style: const TextStyle(fontSize: 35),
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
                  const Text('Loading')
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Text('Go To Settings and Enter City Properly');
            } else {
              return Column(
                children: [
                  SizedBox(
                    //color: Colors.white,
                    height: size.height*0.2,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                  width: size.width * 0.4,
                                  child: Image.asset(
                                      weatherIcons[snapshot.data?['weather'][0]['main']]!
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
                    ),
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
