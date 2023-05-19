import 'dart:convert';
import 'package:converter/converter.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/data.dart';
import 'package:weather_app/users.dart';
import 'package:intl/intl.dart';

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
    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return decodedResponse;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<Map<String, dynamic>> _getForecast(String targetTime) async {
    if (targetTime == ''){
      throw Exception('No Preferred Time');
    }
    final apiKey = UserInfo().getAPIkey();
    final encodedCityName = Uri.encodeComponent(UserInfo().getCity());
    final url = 'https://api.openweathermap.org/data/2.5/forecast?q=$encodedCityName&appid=$apiKey';
    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final forecastList = decodedResponse['list'];

      // Parse the target time string
      final parsedTime = DateFormat('HH:mm:ss').parse(targetTime);
      final targetDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        parsedTime.hour,
        parsedTime.minute,
        parsedTime.second,
      );

      // Find the closest matching forecast for the target time
      final closestForecast = forecastList.reduce((a, b) {
        final aTime = DateTime.fromMillisecondsSinceEpoch(a['dt'] * 1000).toLocal();
        final bTime = DateTime.fromMillisecondsSinceEpoch(b['dt'] * 1000).toLocal();
        final aDiff = aTime.difference(targetDateTime).inSeconds.abs();
        final bDiff = bTime.difference(targetDateTime).inSeconds.abs();
        return aDiff < bDiff ? a : b;
      });
      // Extract the desired weather information from the closest forecast
      return closestForecast;
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
    return SingleChildScrollView(
      child: Center(
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
              } else if (snapshot.hasError) {
                return const Text('Go To Settings and Enter City Properly');
              }
              return Container(
                width: size.width * 0.9,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.5),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                                width: size.width * 0.4,
                                child: Image.asset(WeatherData().weatherIcons[
                                    snapshot.data?['weather'][0]['description']]!
                                )
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(snapshot.data?['weather'][0]['description']!)
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Current',
                              style: TextStyle(fontSize: 30),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              '${Temperature(snapshot.data!['main']['temp'], 'K').valueIn('C').round()} °C',
                              style: const TextStyle(fontSize: 28),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                                '${DateTime.now().hour}:${_twoDigits(DateTime.now().minute)}')
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.06),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Your Typical Running Time',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          FutureBuilder(
              future: _getForecast(UserInfo().getPreferredTimes()[DateFormat('E').format(DateTime.now())]!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [
                      Lottie.asset('assets/anims/loading.json'),
                      const Text('Loading')
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Text('No Preferred Time Chosen', style: TextStyle(fontSize: 10),);
                }
                String time = UserInfo().getPreferredTimes()[DateFormat('E').format(DateTime.now())]!.substring(0, 5);
                String hourPlusOne = '${int.parse(time.substring(0,2)) + 1}:00';
                return Container(
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[700]!, width: 2.5),
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(children: [
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Text(
                        '$time - $hourPlusOne',
                        style: const TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                  width: size.width * 0.2,
                                  child: Image.asset(WeatherData().weatherIcons[
                                  snapshot.data?['weather'][0]['description']]!)),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Text(snapshot.data?['weather'][0]['description']!)
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.thermostat, size: 40,),
                                  Text(
                                    '${Temperature(snapshot.data!['main']['temp'], 'K').valueIn('C').round()} °C',
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.air),
                                  SizedBox(width: size.width*0.02,),
                                  Text("${snapshot.data!['wind']['speed']} Knots")
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.remove_red_eye),
                                  SizedBox(width: size.width*0.02,),
                                  Text("${snapshot.data!['visibility']} m")
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height*0.02,
                      )
                    ]));
              })
        ]),
      ),
    );
  }
}
