import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:weather_app/pages/welcomeBase.dart';
import 'package:http/http.dart' as http;

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  void _displayDeleteMotionToast(String title, String description) {
    MotionToast.info(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(description),
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
    ).show(context);
  }

  Future<bool> isValidCity(String cityName) async {
    const apiKey = '3194812ebdac044591796f914fbabf78';
    final encodedCityName = Uri.encodeComponent(cityName);
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$encodedCityName&appid=$apiKey';
    print(url);
    print(url);
    final response = await http.get(Uri.parse(url));
    print(response);
    final decodedResponse = jsonDecode(response.body);
    return decodedResponse['cod'] == 200;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          Lottie.asset('assets/anims/weather.json'),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.05),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Welcome',
                      style: TextStyle(fontSize: 35),
                    )),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Let's Get Running",
                      style: TextStyle(fontSize: 35),
                    )),
                SizedBox(
                  height: size.height * 0.1,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "What City Are You From?",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.08,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.5),
                        borderRadius: BorderRadius.circular(12)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.01, right: size.width * 0.01),
                        child: TextFormField(
                          scrollPadding: EdgeInsets.only(bottom: size.height*0.4),
                          controller: baseKey.currentState?.city,
                          autocorrect: false,
                          focusNode: baseKey.currentState?.cityFocus,
                          decoration: InputDecoration(
                              hintText: 'Name Your City...',
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          GestureDetector(
            onTap: () async {
              baseKey.currentState?.cityFocus.unfocus();
              bool valid = await isValidCity(
                  baseKey.currentState!.city.value.text);
              if (valid) {
                baseKey.currentState?.nextPressed();
              } else {
                _displayDeleteMotionToast('Invalid City', 'Enter a valid city');
              }
            },
            child: Container(
              width: size.width * 0.4,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.5),
                  borderRadius: BorderRadius.circular(12)),
              child: const Center(
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height*0.11,
          )
        ],
      ),
    );
  }
}
