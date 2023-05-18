import 'package:flutter/material.dart';
import 'package:weather_app/pages/homeBase.dart';
import 'package:weather_app/pages/welcomeBase.dart';
import 'package:weather_app/users.dart';

class Pref extends StatefulWidget {
  const Pref({Key? key}) : super(key: key);

  @override
  State<Pref> createState() => _PrefState();
}

class _PrefState extends State<Pref> {
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
                alignment: Alignment.topCenter,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "When do you usually run each day?",
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
                      const Text(
                        "Mon",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      DropdownMenu(
                        width: size.width * 0.4,
                        dropdownMenuEntries: timeRanges,
                        onSelected: (value) {
                          welcomeBaseKey.currentState?.preferredTimes['monday'] =
                              value;
                        },
                      )
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
                          welcomeBaseKey.currentState?.preferredTimes['tuesday'] =
                              value;
                        },
                      )
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
                        width: size.width * 0.045,
                      ),
                      DropdownMenu(
                        width: size.width * 0.4,
                        dropdownMenuEntries: timeRanges,
                        onSelected: (value) {
                          welcomeBaseKey.currentState?.preferredTimes['wednesday'] =
                              value;
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Thur",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      DropdownMenu(
                        width: size.width * 0.4,
                        dropdownMenuEntries: timeRanges,
                        onSelected: (value) {
                          welcomeBaseKey.currentState?.preferredTimes['thursday'] =
                              value;
                        },
                      )
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
                        width: size.width * 0.085,
                      ),
                      DropdownMenu(
                        width: size.width * 0.4,
                        dropdownMenuEntries: timeRanges,
                        onSelected: (value) {
                          welcomeBaseKey.currentState?.preferredTimes['friday'] =
                              value;
                        },
                      )
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
                          welcomeBaseKey.currentState?.preferredTimes['saturday'] =
                              value;
                        },
                      )
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
                        width: size.width * 0.055,
                      ),
                      DropdownMenu(
                        width: size.width * 0.4,
                        dropdownMenuEntries: timeRanges,
                        onSelected: (value) {
                          welcomeBaseKey.currentState?.preferredTimes['sunday'] =
                              value;
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
            setState(() {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HomeBase(
                    userInfo: UserInfo(
                        cityName: welcomeBaseKey.currentState!.city.text,
                        preferredTimes: welcomeBaseKey.currentState!.preferredTimes),
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    final begin = const Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    final tween = Tween(begin: begin, end: end);
                    final curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    );
                    return SlideTransition(
                      position: tween.animate(curvedAnimation),
                      child: child,
                    );
                  },
                ),
              );
            });
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
