import 'package:flutter/material.dart';
import 'package:weather_app/users.dart';

class Pref extends StatefulWidget {
  final VoidCallback nextPressed;
  const Pref({Key? key, required this.nextPressed}) : super(key: key);

  @override
  State<Pref> createState() => _PrefState();
}

class _PrefState extends State<Pref> {
  final UserInfo _userInfo = UserInfo.getInstance();
  final List<DropdownMenuEntry> _timeRanges = [
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(children: [
        SizedBox(
          height: size.height * 0.175,
        ),
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.05),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "When do you like to run each day?",
                    style: TextStyle(fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Column(
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
                        onSelected: (value) {
                          _userInfo.setPreferredTimes('monday', value);
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
                        dropdownMenuEntries: _timeRanges,
                        onSelected: (value) {
                          _userInfo.setPreferredTimes('tuesday', value);
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
                        onSelected: (value) {
                          _userInfo.setPreferredTimes('wednesday', value);
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
                        onSelected: (value) {
                          _userInfo.setPreferredTimes('thursday', value);
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
                        onSelected: (value) {
                          _userInfo.setPreferredTimes('friday', value);
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
                        onSelected: (value) {
                          _userInfo.setPreferredTimes('saturday', value);
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
                        onSelected: (value) {
                          _userInfo.setPreferredTimes('sunday', value);
                        },
                      )
                    ],
                  ),
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
            widget.nextPressed();
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
      ]),
    );
  }
}
