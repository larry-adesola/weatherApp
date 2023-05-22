import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/data.dart';
import 'package:weather_app/pages/detailedDialog.dart';
import 'package:weather_app/users.dart';
import 'package:weather_app/weatherapi.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Column(children: [
          SizedBox(
            height: size.height * 0.08,
          ),
          Text(
            UserInfo().getLocation(),
            style: const TextStyle(fontSize: 35),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          FutureBuilder(
            future: Weather().getWeather(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: [Lottie.asset('assets/anims/loading.json'), const Text('Loading')],
                );
              } else if (snapshot.hasError) {
                return const Text('Enter valid city in settings');
              }
              Map<String, dynamic> data = snapshot.data!;
              return GestureDetector(
                onTap: () => DetailedDialog().buildDetailedDialog(context, snapshot, size),
                child: Container(
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue[700]!, width: 2.5),
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
                                  child: Image.asset(WeatherData().getWeatherIcon(data['weather'][0]['main']))),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(data['weather'][0]['description']!)
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
                                '${data['main']['temp'].round()} °C',
                                style: const TextStyle(fontSize: 28),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(DateFormat('jm')
                                  .format(DateTime.now().toUtc().add(Duration(seconds: UserInfo().getTimezone()))))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          FutureBuilder(
              future: Weather().getForecast(UserInfo().getPreferredTimes()[DateFormat('E').format(DateTime.now())]!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [Lottie.asset('assets/anims/loading.json'), const Text('Loading')],
                  );
                } else if (snapshot.hasError) {
                  return const Text(
                    'No Preferred Time Chosen',
                    style: TextStyle(fontSize: 10),
                  );
                }
                Map<String, dynamic> data = snapshot.data!;
                String startTime =
                    UserInfo().getPreferredTimes()[DateFormat('E').format(DateTime.now())]!.substring(0, 5);
                String endTime = '${(int.parse(startTime.substring(0, 2)) + 1).toString().padLeft(2, '0')}:00';
                double temp = data['main']['temp'];
                return Container(
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[700]!, width: 2.5),
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(children: [
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Your Preferred Running Time',
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Text(
                        '$startTime - $endTime',
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
                                  child: Image.asset(WeatherData().getWeatherIcon(data['weather'][0]['main']))),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Text(data['weather'][0]['description']!)
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.thermostat, size: 40),
                                  Text('${temp.round()} °C', style: const TextStyle(fontSize: 30)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.air),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text("${(data['wind']['speed'] * 3.6).toStringAsFixed(0)} kmh")
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.water_drop),
                                  const Text('Humidity'),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text(
                                    '${data['main']['humidity']}%',
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.sunny),
                                  const Text('UV'),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  const Text(
                                    '3 - Low',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.remove_red_eye),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text("${snapshot.data!['visibility']} m")
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.cloud),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  const Text('Air Quality'),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  const Text(
                                    '3 - Low',
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Row(
                                children: [
                                  const Text('Outfit:'),
                                  SizedBox(
                                    width: size.width * 0.08,
                                  ),
                                  Image.asset(
                                    UserInfo().outfitChoose(temp),
                                    scale: 1.4,
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      )
                    ]));
              }),
          SizedBox(
            height: size.height * 0.02,
          )
        ]),
      ),
    );
  }
}
