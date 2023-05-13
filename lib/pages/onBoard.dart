import 'package:flutter/material.dart';

class Pref extends StatefulWidget {
  const Pref({Key? key}) : super(key: key);

  @override
  State<Pref> createState() => _PrefState();
}

class _PrefState extends State<Pref> {
  final List<DropdownMenuEntry> timeRanges = [
    DropdownMenuEntry(value: '6am - 7am', label: '6am - 7am'),
    DropdownMenuEntry(value: '7am - 8am', label: '7am - 8am'),
    DropdownMenuEntry(value: '8am - 9am', label: '8am - 9am'),
    DropdownMenuEntry(value: '9am - 10am', label: '9am - 10am'),
    DropdownMenuEntry(value: '10am - 11am', label: '10am - 11am'),
    DropdownMenuEntry(value: '11am - 12pm', label: '11am - 12pm'),
    DropdownMenuEntry(value: '12pm - 1pm', label: '12pm - 1pm'),
    DropdownMenuEntry(value: '1pm - 2pm', label: '1am - 2am'),
    DropdownMenuEntry(value: '2pm - 3pm', label: '2pm - 3pm'),
    DropdownMenuEntry(value: '3pm - 4pm', label: '3pm - 4pm'),
    DropdownMenuEntry(value: '4pm - 5pm', label: '4pm - 5pm'),
    DropdownMenuEntry(value: '5pm - 6pm', label: '5pm - 6pm'),
    DropdownMenuEntry(value: '6pm - 7pm', label: '6pm - 7pm'),
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
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "When Do You Usually Run Each Day?",
                    style: TextStyle(fontSize: 27),
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
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,),
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
        Container(
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
      ]),
    );
  }
}
