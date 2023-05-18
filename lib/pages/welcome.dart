import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../users.dart';

class Welcome extends StatefulWidget {
  final VoidCallback nextPressed;
  const Welcome({Key? key, required this.nextPressed}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final TextEditingController _cityText = TextEditingController();
  final FocusNode _cityFocus = FocusNode();

  void _displayDeleteMotionToast(String title, String description) {
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
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          Lottie.asset('assets/anims/weather.json'),
          SizedBox(
            height: size.height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.05),
            child: Column(
              children: [
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
                  height: size.height * 0.1,
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
                  height: size.height * 0.01,
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
                            left: size.width * 0.01, right: size.width * 0.01),
                        child: TextFormField(
                          scrollPadding: EdgeInsets.only(bottom: size.height*0.4),
                          controller: _cityText,
                          cursorColor: Colors.black,
                          autocorrect: false,
                          focusNode: _cityFocus,
                          decoration: InputDecoration(
                              hintText: 'Put the country after commas...',
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          GestureDetector(
            onTap: () async {
              _cityFocus.unfocus();
              bool valid = await UserInfo().setCity(_cityText.value.text);
              if (valid) {
                widget.nextPressed();
              } else {
                _displayDeleteMotionToast('Invalid City', 'Enter a valid city');
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
                  "Next",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height*0.11,
          )
        ],
      ),
    );
  }
}
