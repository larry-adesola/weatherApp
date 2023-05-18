import 'package:flutter/material.dart';
import 'package:weather_app/users.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final UserInfo _userInfo = UserInfo.getInstance();
  double _currentSliderValue = 0;
  final TextEditingController _settingsCity = TextEditingController();
  final FocusNode _settingsFocus = FocusNode();

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
              ),),
          ),
        ),
        SizedBox(
          height: size.height * 0.075,
        ),
        Padding(
          padding: EdgeInsets.only(left: size.width*0.05, right: size.width*0.05),
          child: Tooltip(
            message: "Adjust the clothing adjustments by the selected temperature." +
                "\ne.g. -3 will give recommendations as if it were 3 °C colder.",
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            textStyle: const TextStyle(fontSize: 14.0),
            child: const Text("Clothing recommendations adjustment"),
          ),
        ),
        Text(
          "${_currentSliderValue.round()} °C",
          style: const TextStyle(fontSize: 18.0),
        ),
        const SizedBox(
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
        SizedBox(
          height: size.height * 0.01,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: size.width * 0.8,
            height: size.height * 0.08,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.5),
                borderRadius: BorderRadius.circular(12)
            ),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.05, right: size.width * 0.05
                ),
                child: TextFormField(
                  scrollPadding: EdgeInsets.only(bottom: size.height*0.4),
                  controller: _settingsCity,
                  autocorrect: false,
                  focusNode: _settingsFocus,
                  decoration: InputDecoration(
                      hintText: 'Put the country after a comma...',
                      hintStyle: TextStyle(color: Colors.grey.shade700),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
