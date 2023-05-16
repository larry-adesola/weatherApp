import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:weather_app/users.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double _currentSliderValue = 0;
  TextEditingController settingsCity = TextEditingController();
  FocusNode settingsFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
          children: [
        SizedBox(
          height: size.height * 0.1,
        ),
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.05),
          child: const Align(alignment: Alignment.topLeft,
              child: Text('Settings', style: TextStyle(
                fontSize: 34
              ),)),
        ),
        SizedBox(
          height: size.height * 0.075,
        ),
        Padding(
          padding: EdgeInsets.only(left: size.width*0.05, right: size.width*0.05),
          child: const Text(
            "Clothing recommendation adjustment",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        Text(
          "${_currentSliderValue.round()}",
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(
          height: 20.0,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.blue),
          ),
        ),
        Slider(
          value: _currentSliderValue,
          min: -5,
          max: 5,
          divisions: 10,
          inactiveColor: Colors.blueGrey,
          activeColor: Colors.yellow,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: size.width*0.05, right: size.width*0.05),
          child: const Text(
            "Change location",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        //// Here the city location change must be
        SizedBox(
          height: size.height * 0.01,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(   //did nothing, just added bar to add the city, made controller and focus
            width: size.width * 0.8,
            height: size.height * 0.08,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.5),
                borderRadius: BorderRadius.circular(12)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.1, right: size.width * 0.1),
                child: TextFormField(
                  scrollPadding: EdgeInsets.only(bottom: size.height*0.4),
                  controller: settingsCity,
                  autocorrect: false,
                  focusNode: settingsFocus,
                  decoration: InputDecoration(
                      hintText: 'Put the country after commas...',
                      hintStyle: TextStyle(color: Colors.grey.shade700),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ),//end of city location
      ]),
    );
  }
}
