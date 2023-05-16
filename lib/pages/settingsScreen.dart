import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double _currentSliderValue = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(children: [
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
        const Text("Clothing recommendation adjustment"),
        Text(
          "${_currentSliderValue}",
          style: TextStyle(fontSize: 25.0),
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
      ]),
    );
  }
}
