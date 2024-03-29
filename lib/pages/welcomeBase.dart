import 'package:flutter/material.dart';
import 'package:weather_app/pages/welcome.dart';
import 'package:weather_app/users.dart';

import 'homeBase.dart';
import 'onBoard.dart';

class WelcomeBase extends StatefulWidget {
  const WelcomeBase({Key? key}) : super(key: key);

  @override
  State<WelcomeBase> createState() => _WelcomeBaseState();
}

class _WelcomeBaseState extends State<WelcomeBase> {
  int onboardStage = 0;

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
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                transform: Matrix4.translationValues(onboardStage == 0 ? 0 : -size.width, 0, 0),
                curve: Curves.decelerate,
                child: Welcome(
                  nextPressed: () {
                    setState(() {
                      onboardStage = 1;
                    });
                  },
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                transform: Matrix4.translationValues((1 - onboardStage) * size.width, 0, 0),
                curve: Curves.decelerate,
                child: Pref(
                  nextPressed: () {
                    UserInfo().setOnboard(true);
                    setState(() {
                      onboardStage = 2;
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const HomeBase(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.decelerate;
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
