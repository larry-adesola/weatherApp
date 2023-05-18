import 'package:flutter/material.dart';
import 'package:weather_app/users.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double _currentSliderValue = 0;
  final TextEditingController _settingsCity = TextEditingController(text: UserInfo().getCity());
  final FocusNode _settingsFocus = FocusNode();
  final _preferredTimes = {
    'Monday': '',
    'Tuesday': '',
    'Wednesday': '',
    'Thursday': '',
    'Friday': '',
    'Saturday': '',
    'Sunday': ''
  };
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
                  "Adjust the clothing adjustments by the selected temperature." +
                      "\ne.g. -3 will give recommendations as if it were 3 °C colder.",
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              textStyle: const TextStyle(fontSize: 14.0),
              child: const Text("Clothing recommendations adjustment"),
            ),
          ),
          Text(
            "${_currentSliderValue.round()} °C",
            style: const TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: size.height*0.02,
            child: const DecoratedBox(
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
                'Changed Preferred Times',
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
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.2,
                      child: const Text(" Mon", style: TextStyle(fontSize: 18),),
                    ),
                    DropdownMenu(
                      width: size.width * 0.65,
                      dropdownMenuEntries: _timeRanges,
                      initialSelection: UserInfo().getPreferredTimes()['Monday'],
                      onSelected: (value) {
                        UserInfo().setPreferredTimes('Monday', value);
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.2,
                      child: const Text(" Tue", style: TextStyle(fontSize: 18),),
                    ),
                    DropdownMenu(
                      width: size.width * 0.65,
                      initialSelection: UserInfo().getPreferredTimes()['Tuesday'],
                      dropdownMenuEntries: _timeRanges,
                      onSelected: (value) {
                        UserInfo().setPreferredTimes('Tuesday', value);
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.2,
                      child: const Text(" Wed", style: TextStyle(fontSize: 18),),
                    ),
                    DropdownMenu(
                      width: size.width * 0.65,
                      dropdownMenuEntries: _timeRanges,
                      initialSelection: UserInfo().getPreferredTimes()['Wednesday'],
                      onSelected: (value) {
                        UserInfo().setPreferredTimes('Wednesday', value);
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.2,
                      child: const Text(" Thu", style: TextStyle(fontSize: 18),),
                    ),
                    DropdownMenu(
                      width: size.width * 0.65,
                      dropdownMenuEntries: _timeRanges,
                      initialSelection: UserInfo().getPreferredTimes()['Thursday'],
                      onSelected: (value) {
                        UserInfo().setPreferredTimes('Thursday', value);
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.2,
                      child: const Text(" Fri", style: TextStyle(fontSize: 18),),
                    ),
                    DropdownMenu(
                      width: size.width * 0.65,
                      dropdownMenuEntries: _timeRanges,
                      initialSelection: UserInfo().getPreferredTimes()['Friday'],
                      onSelected: (value) {
                        UserInfo().setPreferredTimes('Friday', value);
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.2,
                      child: const Text(" Sat", style: TextStyle(fontSize: 18),),
                    ),
                    DropdownMenu(
                      width: size.width * 0.65,
                      dropdownMenuEntries: _timeRanges,
                      initialSelection: UserInfo().getPreferredTimes()['Saturday'],
                      onSelected: (value) {
                        UserInfo().setPreferredTimes('Saturday', value);
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.2,
                      child: const Text(" Sun", style: TextStyle(fontSize: 18),),
                    ),
                    DropdownMenu(
                      width: size.width * 0.65,
                      dropdownMenuEntries: _timeRanges,
                      initialSelection: UserInfo().getPreferredTimes()['Sunday'],
                      onSelected: (value) {
                        UserInfo().setPreferredTimes('Sunday', value);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          GestureDetector(
            onTap: () {
              UserInfo().setCity(_settingsCity.text);
              /*if (_preferredTimes['monday'] != '') {
                UserInfo()
                    .setPreferredTimes('monday', (_preferredTimes['monday'])!);
              }
              if (_preferredTimes['tuesday'] != '') {
                UserInfo().setPreferredTimes(
                    'tuesday', (_preferredTimes['tuesday'])!);
              }
              if (_preferredTimes['wednesday'] != '') {
                UserInfo().setPreferredTimes(
                    'wednesday', (_preferredTimes['wednesday'])!);
              }
              if (_preferredTimes['thursday'] != '') {
                UserInfo().setPreferredTimes(
                    'thursday', (_preferredTimes['thursday'])!);
              }
              if (_preferredTimes['friday'] != '') {
                UserInfo()
                    .setPreferredTimes('friday', (_preferredTimes['friday'])!);
              }
              if (_preferredTimes['saturday'] != '') {
                UserInfo().setPreferredTimes(
                    'saturday', (_preferredTimes['saturday'])!);
              }
              if (_preferredTimes['sunday'] != '') {
                UserInfo()
                    .setPreferredTimes('sunday', (_preferredTimes['sunday'])!);
              }*/
              //dont think all that is necessary as there is a setPreferred for each dropmenu already
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
