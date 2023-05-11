import 'package:flutter/material.dart';



class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: size.width*0.05),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height*0.2,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                      child: Text('Welcome',
                      style: TextStyle(
                        fontSize: 35
                      ),)),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Let's Get Running",
                        style: TextStyle(
                            fontSize: 35
                        ),)),
                  SizedBox(
                    height: size.height*0.08,
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
                  SizedBox(height: size.height*0.02,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: size.width*0.8,
                      height: size.height*0.08,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2.5),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width*0.01, right: size.width*0.01),
                          child: TextFormField(
                            //controller: emailControl,
                            autocorrect: false,
                            //focusNode: emailFocusNode,
                            decoration: const InputDecoration(
                                hintText: 'Name Your City...',
                                hintStyle: TextStyle(
                                    color: Colors.grey
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none
                            ),
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.08,
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
                    height: size.height*0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Mon",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: size.height*0.01,
                          ),
                          const Text(
                            "Tue",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: size.height*0.01,
                          ),
                          const Text(
                            "Wed",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Thur",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: size.height*0.01,
                          ),
                          const Text(
                            "Fri",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: size.height*0.01,
                          ),
                          const Text(
                            "Sat",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: size.height*0.01,
                          ),
                          const Text(
                            "Sun",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
