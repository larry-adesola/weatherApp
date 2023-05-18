import 'package:flutter/material.dart';
import 'package:weather_app/users.dart';

class Pref extends StatefulWidget {
  final VoidCallback nextPressed;
  const Pref({Key? key, required this.nextPressed}) : super(key: key);

  @override
  State<Pref> createState() => _PrefState();
}

class _PrefState extends State<Pref> {
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
                        onSelected: (value) {
                          UserInfo().setPreferredTimes('Sunday', value);
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
