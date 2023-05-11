import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
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
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blue[100],
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: size.width * 0.05),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Welcome',
                        style: TextStyle(fontSize: 35),
                      )),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Let's Get Running",
                        style: TextStyle(fontSize: 35),
                      )),
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "What City Are You From?",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: size.width * 0.8,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2.5),
                          borderRadius: BorderRadius.circular(12)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.01,
                              right: size.width * 0.01),
                          child: TextFormField(
                            //controller: emailControl,
                            autocorrect: false,
                            //focusNode: emailFocusNode,
                            decoration: const InputDecoration(
                                hintText: 'Name Your City...',
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "When Do You Usually Run Each Day?",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Mon",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: size.width*0.02,
                              ),
                              DropdownMenu(
                                width: size.width*0.3,
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
                                width: size.width*0.02,
                              ),
                              DropdownMenu(
                                width: size.width*0.3,
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
                                width: size.width*0.02,
                              ),
                              DropdownMenu(
                                width: size.width*0.3,
                                dropdownMenuEntries: timeRanges,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: size.width*0.01,),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Thur",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: size.width*0.02,
                              ),
                              DropdownMenu(
                                width: size.width*0.3,
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
                                width: size.width*0.02,
                              ),
                              DropdownMenu(
                                width: size.width*0.3,
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
                                width: size.width*0.02,
                              ),
                              DropdownMenu(
                                width: size.width*0.3,
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
                                width: size.width*0.02,
                              ),
                              DropdownMenu(
                                width: size.width*0.3,
                                dropdownMenuEntries: timeRanges,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: size.height*0.04,),
                  Container(
                    width: size.width*0.4,
                    height: size.height*0.05,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.5),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: const Center(
                      child: Text(
                        "Next", style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
