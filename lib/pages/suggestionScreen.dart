import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data.dart';
import 'package:weather_app/pages/detailedDialog.dart';
import 'package:weather_app/users.dart';
import 'package:weather_app/weatherapi.dart';
import 'package:converter/converter.dart';
import 'package:lottie/lottie.dart';

class SuggScreen extends StatefulWidget {
  const SuggScreen({Key? key}) : super(key: key);

  @override
  State<SuggScreen> createState() => _SuggScreenState();
}

class _SuggScreenState extends State<SuggScreen> {
  int _selectedDay = 0; //current day is selected by default
  final String currentDay = DateFormat('EEE').format(DateTime.now());
  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentDayIndex = days.indexOf(currentDay);

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.05),
                  // Move buttons down by 50 pixels
                  child: ButtonBar(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedDay = 0;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(70, 70),
                          backgroundColor: _selectedDay == 0 ? Colors.blue : null,
                          shape:
                              const CircleBorder(), // Change color when selected
                        ),
                        child: Text(
                          currentDay,
                          style: TextStyle(
                            color:
                                _selectedDay == 0 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedDay = 1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(70, 70),
                          shape: const CircleBorder(),
                          backgroundColor: _selectedDay == 1
                              ? Colors.blue
                              : null, // Change color when selected
                        ),
                        child: Text(
                          days[(currentDayIndex + 1) % 7],
                          style: TextStyle(
                            color:
                                _selectedDay == 1 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedDay = 2;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(70, 70),
                          backgroundColor: _selectedDay == 2 ? Colors.blue : null,
                          shape:
                              const CircleBorder(), // Change color when selected
                        ),
                        child: Text(
                          days[(currentDayIndex + 2) % 7],
                          style: TextStyle(
                            color:
                                _selectedDay == 2 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedDay = 3;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(70, 70),
                          backgroundColor: _selectedDay == 3 ? Colors.blue : null,
                          shape:
                              const CircleBorder(), // Change color when selected
                        ),
                        child: Text(
                          days[(currentDayIndex + 3) % 7],
                          style: TextStyle(
                            color:
                                _selectedDay == 3 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            FutureBuilder(
                future: Weather().getForecastSuggestion(_selectedDay, 4, 11),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        Lottie.asset('assets/anims/loading.json'),
                        const Text('Loading')
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                      'Error creating suggestions',
                      style: TextStyle(fontSize: 10),
                    );
                  }
                  print(_selectedDay);
                  print(snapshot.data?['dt']);
                  String time = DateFormat('HH:mm')
                      .format(DateTime.fromMillisecondsSinceEpoch(
                              snapshot.data?['dt'] * 1000)
                          .toLocal())
                      .substring(0, 5);
                  String hourPlusOne =
                      '${_twoDigits(int.parse(time.substring(0, 2)) + 1)}:00';

                  int temp = Temperature(snapshot.data!['main']['temp'], 'K')
                      .valueIn('C')
                      .round();
                  return Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blue[700]!, width: 2.5),
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
                                        snapshot.data?['weather'][0]['main']]!)),
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
                                    const Icon(
                                      Icons.thermostat,
                                      size: 40,
                                    ),
                                    Text(
                                      '${temp} °C',
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                      ]));
                }),
            SizedBox(
              height: size.height * 0.025,
            ),
            FutureBuilder(
                future: Weather().getForecastSuggestion(_selectedDay, 12, 16),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        Lottie.asset('assets/anims/loading.json'),
                        const Text('Loading')
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                      'Error creating suggestions',
                      style: TextStyle(fontSize: 10),
                    );
                  }
                  print(_selectedDay);
                  print(snapshot.data?['dt']);
                  String time = DateFormat('HH:mm')
                      .format(DateTime.fromMillisecondsSinceEpoch(
                              snapshot.data?['dt'] * 1000)
                          .toLocal())
                      .substring(0, 5);
                  String hourPlusOne =
                      '${_twoDigits(int.parse(time.substring(0, 2)) + 1)}:00';
                  int temp = Temperature(snapshot.data!['main']['temp'], 'K')
                      .valueIn('C')
                      .round();
                  return Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blue[700]!, width: 2.5),
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
                                        snapshot.data?['weather'][0]['main']]!)),
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
                                    const Icon(
                                      Icons.thermostat,
                                      size: 40,
                                    ),
                                    Text(
                                      '${temp} °C',
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                      ]));
                }),
            SizedBox(
              height: size.height * 0.025,
            ),
            FutureBuilder(
                future: Weather().getForecastSuggestion(_selectedDay, 17, 22),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        Lottie.asset('assets/anims/loading.json'),
                        const Text('Loading')
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                      'Error creating suggestions',
                      style: TextStyle(fontSize: 10),
                    );
                  }
                  String time = DateFormat('HH:mm')
                      .format(DateTime.fromMillisecondsSinceEpoch(
                              snapshot.data?['dt'] * 1000)
                          .toLocal())
                      .substring(0, 5);
                  String hourPlusOne =
                      '${_twoDigits(int.parse(time.substring(0, 2)) + 1)}:00';
                  int temp = Temperature(
                      snapshot.data!['main']['temp'], 'K')
                      .valueIn('C')
                      .round();
                  return Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue[700]!, width: 2.5),
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
                                    child: Image.asset(
                                        WeatherData().weatherIcons[
                                        snapshot
                                            .data?['weather'][0]['main']]!)),
                                SizedBox(
                                  height: size.height * 0.005,
                                ),
                                Text(snapshot
                                    .data?['weather'][0]['description']!)
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
                                      '${temp} °C',
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                      ]));
                }),
          ],
        ),
      ),
    );
  }
}
