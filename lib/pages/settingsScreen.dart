import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:weather_app/users.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _clothingScore = UserInfo().getClothingScore();
  final TextEditingController _settingsCity = TextEditingController(text: UserInfo().getCity());
  final FocusNode _settingsFocus = FocusNode();
  final Map<String, String> _preferredTimes = UserInfo().getPreferredTimes();
  final List<DropdownMenuEntry> _timeRanges = [
    const DropdownMenuEntry(value: '', label: 'No Preferred Time'),
    const DropdownMenuEntry(value: '06:00:00', label: '6am - 7am'),
    const DropdownMenuEntry(value: '07:00:00', label: '7am - 8am'),
    const DropdownMenuEntry(value: '08:00:00', label: '8am - 9am'),
    const DropdownMenuEntry(value: '09:00:00', label: '9am - 10am'),
    const DropdownMenuEntry(value: '10:00:00', label: '10am - 11am'),
    const DropdownMenuEntry(value: '11:00:00', label: '11am - 12pm'),
    const DropdownMenuEntry(value: '12:00:00', label: '12pm - 1pm'),
    const DropdownMenuEntry(value: '13:00:00', label: '1pm - 2pm'),
    const DropdownMenuEntry(value: '14:00:00', label: '2pm - 3pm'),
    const DropdownMenuEntry(value: '15:00:00', label: '3pm - 4pm'),
    const DropdownMenuEntry(value: '16:00:00', label: '4pm - 5pm'),
    const DropdownMenuEntry(value: '17:00:00', label: '5pm - 6pm'),
    const DropdownMenuEntry(value: '18:00:00', label: '6pm - 7pm'),
    const DropdownMenuEntry(value: '19:00:00', label: '7pm - 8pm'),
    const DropdownMenuEntry(value: '20:00:00', label: '8pm - 9pm'),
    const DropdownMenuEntry(value: '21:00:00', label: '9pm- 10pm'),
  ];

  void _displayNotification(String title, String description) {
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Column(children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.05),
            child: const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Settings',
                  style: TextStyle(fontSize: 34),
                )),
          ),
          //),
          SizedBox(
            height: size.height * 0.075,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.05, right: size.width * 0.05),
            child: Tooltip(
              message:
                  "Adjust the clothing adjustments by the selected temperature."
                      "\ne.g. -3 will give recommendations as if it were 3 °C colder.",
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              textStyle: const TextStyle(fontSize: 14.0),
              child: const Text("Clothing recommendations adjustment"),
            ),
          ),
          Text(
            "$_clothingScore °C",
            style: const TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: size.height*0.02,
            child: const DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
            ),
          ),
          Slider(
            value: _clothingScore.toDouble(),
            min: -5,
            max: 5,
            divisions: 10,
            inactiveColor: Colors.blueGrey,
            activeColor: Colors.yellow,
            label: _clothingScore.toString(),
            onChanged: (double value) {
              setState(() {
                _clothingScore = value.round();
              });
            },
          ),
          SizedBox(height: size.height*0.05,),
          const Text(
            "Change location",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: size.width * 0.8,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.5),
                  borderRadius: BorderRadius.circular(12)),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.01, right: size.width * 0.01),
                  child: TextFormField(
                    scrollPadding: EdgeInsets.only(bottom: size.height * 0.4),
                    controller: _settingsCity,
                    autocorrect: false,
                    focusNode: _settingsFocus,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey.shade700),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Change Preferred Times',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.05),
            child: Column(
              children: [ for (String day in _preferredTimes.keys)
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.2,
                      child: Text(day, style: const TextStyle(fontSize: 18),),
                    ),
                    DropdownMenu(
                      width: size.width * 0.65,
                      dropdownMenuEntries: _timeRanges,
                      initialSelection: _preferredTimes[day],
                      onSelected: (value) {
                        _preferredTimes[day] = value;
                        print(_preferredTimes);
                        print(UserInfo().getPreferredTimes());
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                )
              ]
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          GestureDetector(
            onTap: () async {
              _settingsFocus.unfocus();
              bool valid = await UserInfo().setCity(_settingsCity.value.text);
              if (valid) {
                UserInfo().setClothingScore(_clothingScore);
                for (String key in _preferredTimes.keys) {
                  UserInfo().setPreferredTimes(key, _preferredTimes[key]!);
                }
                _displayNotification("Saved", "Your changes have been saved");
              } else {
                _displayNotification('Invalid City', 'Enter a valid city');
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
                  "SAVE",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height*0.05,
          )
        ]),
      ),
    );
  }
}
