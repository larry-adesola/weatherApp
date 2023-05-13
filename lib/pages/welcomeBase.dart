import 'package:flutter/material.dart';
import 'package:weather_app/pages/welcome.dart';

import 'onBoard.dart';

final GlobalKey<_WelcomeBaseState> baseKey = GlobalKey<_WelcomeBaseState>();

class WelcomeBase extends StatefulWidget {
  const WelcomeBase({Key? key}) : super(key: key);

  @override
  State<WelcomeBase> createState() => _WelcomeBaseState();
}

class _WelcomeBaseState extends State<WelcomeBase> {
  bool welcomeOn = true;
  bool prefOn = false;

  void nextPressed() {
    setState(() {
      welcomeOn = false;
      prefOn = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              AnimatedContainer(duration: const Duration(milliseconds: 500),
                transform: Matrix4.translationValues(welcomeOn? 0:-size.width, 0, 0),
                curve: Curves.decelerate,
              child: const Welcome(),),
              AnimatedContainer(duration: const Duration(milliseconds: 500),
                transform: Matrix4.translationValues(prefOn? 0:size.width, 0, 0),
                curve: Curves.easeInOut,
                child: const Pref(),),
            ],
          ),
        ),
      ),
    );
  }
}
