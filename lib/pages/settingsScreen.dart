import 'package:flutter/material.dart';
import 'package:weather_app/users.dart';

class SettingScreen extends StatefulWidget {
  UserInfo userInfo;
  SettingScreen({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final UserInfo _userInfo = UserInfo.getInstance();
  double _currentSliderValue = 0;
  TextEditingController settingsCity = TextEditingController();
  FocusNode settingsFocus = FocusNode();
  var preferredTimes = {
    'monday': '',
    'tuesday': '',
    'wednesday': '',
    'thursday': '',
    'friday': '',
    'saturday': '',
    'sunday': ''
  };
  final List<DropdownMenuEntry> timeRanges = [
    const DropdownMenuEntry(value: '', label: 'No Preferred Time'),
    const DropdownMenuEntry(value: '6am - 7am', label: '6am - 7am'),
    const DropdownMenuEntry(value: '7am - 8am', label: '7am - 8am'),
    const DropdownMenuEntry(value: '8am - 9am', label: '8am - 9am'),
    const DropdownMenuEntry(value: '9am - 10am', label: '9am - 10am'),
    const DropdownMenuEntry(value: '10am - 11am', label: '10am - 11am'),
    const DropdownMenuEntry(value: '11am - 12pm', label: '11am - 12pm'),
    const DropdownMenuEntry(value: '12pm - 1pm', label: '12pm - 1pm'),
    const DropdownMenuEntry(value: '1pm - 2pm', label: '1pm - 2pm'),
    const DropdownMenuEntry(value: '2pm - 3pm', label: '2pm - 3pm'),
    const DropdownMenuEntry(value: '3pm - 4pm', label: '3pm - 4pm'),
    const DropdownMenuEntry(value: '4pm - 5pm', label: '4pm - 5pm'),
    const DropdownMenuEntry(value: '5pm - 6pm', label: '5pm - 6pm'),
    const DropdownMenuEntry(value: '6pm - 7pm', label: '6pm - 7pm'),
    const DropdownMenuEntry(value: '7pm - 8pm', label: '7pm - 8pm'),
    const DropdownMenuEntry(value: '8pm - 9pm', label: '8pm - 9pm'),
    const DropdownMenuEntry(value: '9pm - 10pm', label: '9pm- 10pm'),
  ];
  final TextEditingController _settingsCity = TextEditingController();
  final FocusNode _settingsFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
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
        //),
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
              SizedBox(
                height: size.height * 0.1,
              ),
              Column( children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    const Text(
                      "Mon",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: size.width * 0.065,
                    ),
                    DropdownMenu(
                      width: size.width * 0.4,
                      dropdownMenuEntries: timeRanges,
                      onSelected: (value) {
                        //isaac;
                        preferredTimes?['monday']=value;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    const Text(
                      "Tue",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: size.width * 0.065,
                    ),
                    DropdownMenu(
                      width: size.width * 0.4,
                      dropdownMenuEntries: timeRanges,
                      onSelected: (value) {
                        //isaac;
                        preferredTimes?['tuesday']=value;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    const Text(
                      "Wed",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: size.width * 0.065,
                    ),
                    DropdownMenu(
                      width: size.width * 0.4,
                      dropdownMenuEntries: timeRanges,
                      onSelected: (value) {
                        //isaac;
                        preferredTimes?['wednesday']=value;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    const Text(
                      "Thu",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: size.width * 0.065,
                    ),
                    DropdownMenu(
                      width: size.width * 0.4,
                      dropdownMenuEntries: timeRanges,
                      onSelected: (value) {
                        preferredTimes?['thursday']=value;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    const Text(
                      "Fri",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: size.width * 0.065,
                    ),
                    DropdownMenu(
                      width: size.width * 0.4,
                      dropdownMenuEntries: timeRanges,
                      onSelected: (value) {
                        preferredTimes?['friday']=value;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    const Text(
                      "Sat",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: size.width * 0.065,
                    ),
                    DropdownMenu(
                      width: size.width * 0.4,
                      dropdownMenuEntries: timeRanges,
                      onSelected: (value) {
                        preferredTimes?['saturday']=value;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    const Text(
                      "Sun",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: size.width * 0.065,
                    ),
                    DropdownMenu(
                      width: size.width * 0.4,
                      dropdownMenuEntries: timeRanges,
                      onSelected: (value) {
                        preferredTimes?['sunday']=value;
                      },
                    ),
                  ],
                ),
              ],

              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              GestureDetector(
                onTap: (){
                  //widget.userInfo.cityName = settingsCity.text;
                  //widget.userInfo.preferredTimes =
                  //_settingsCity
                  widget.userInfo.setCity(settingsCity.text);

                  if(preferredTimes['monday']!=''){
                    //widget.userInfo.preferredTimes?['monday'] = preferredTimes['monday']!;
                    widget.userInfo.setPreferredTimes('monday', (preferredTimes['monday'])!);
                  }
                  if(preferredTimes['tuesday']!=''){
                    //widget.userInfo.preferredTimes?['tuesday'] = preferredTimes['tuesday']!;
                    widget.userInfo.setPreferredTimes('tuesday', (preferredTimes['tuesday'])!);
                  }
                  if(preferredTimes['wednesday']!=''){
                    //widget.userInfo.preferredTimes?['wednesday'] = preferredTimes['wednesday']!;
                    widget.userInfo.setPreferredTimes('wednesday', (preferredTimes['wednesday'])!);
                  }
                  if(preferredTimes['thursday']!=''){
                    //widget.userInfo.preferredTimes?['thursday'] = preferredTimes['thursday']!;
                    widget.userInfo.setPreferredTimes('thursday', (preferredTimes['thursday'])!);
                  }
                  if(preferredTimes['friday']!=''){
                    // widget.userInfo.preferredTimes?['friday'] = preferredTimes['friday']!;
                    widget.userInfo.setPreferredTimes('friday', (preferredTimes['friday'])!);
                  }
                  if(preferredTimes['saturday']!=''){
                    // widget.userInfo.preferredTimes?['saturday'] = preferredTimes['saturday']!;
                    widget.userInfo.setPreferredTimes('saturday', (preferredTimes['saturday'])!);
                  }
                  if(preferredTimes['sunday']!=''){
                    //widget.userInfo.preferredTimes?['sunday'] = preferredTimes['sunday']!;
                    widget.userInfo.setPreferredTimes('sunday', (preferredTimes['sunday'])!);
                  }
                },
                child: Container(
                  color: Colors.amber,
                  padding: const EdgeInsets.all(8),
                  child: Text("SAVE"),
                ),
              ),
      ]),
      ),
    );
  }
}
