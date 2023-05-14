import 'package:flutter/material.dart';
import 'package:weather_app/pages/mainScreen.dart';
import 'package:weather_app/pages/settingsScreen.dart';
import 'package:weather_app/pages/suggestionScreen.dart';

class HomeBase extends StatefulWidget {
  const HomeBase({Key? key}) : super(key: key);

  @override
  State<HomeBase> createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> {
  bool mainOn = true;
  bool suggOn = false;
  bool settingOn = false;

  void suggPressed() {
    setState(() {
      mainOn = false;
      suggOn = true;
      settingOn = false;
    });
  }

  void homePressed() {
    setState(() {
      mainOn = true;
      suggOn = false;
      settingOn = false;
    });
  }

  void settingPressed() {
    setState(() {
      mainOn = false;
      suggOn = false;
      settingOn = true;
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
          child: Column(
            children: [
              SizedBox(
                height: size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      transform: Matrix4.translationValues(
                          mainOn ? 0 : -size.width, 0, 0),
                      curve: Curves.decelerate,
                      child: const MainScreen(),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      transform: Matrix4.translationValues(
                          suggOn ? 0 : size.width, 0, 0),
                      curve: Curves.easeInOut,
                      child: const SuggScreen(),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      transform: Matrix4.translationValues(
                          settingOn ? 0 : -size.width, 0, 0),
                      curve: Curves.decelerate,
                      child: const SettingScreen(),
                    ),
                    Positioned(
                      top: size.height*0.88,
                      child: Material(
                        color: Colors.blue,
                        shadowColor: Colors.black26,
                        elevation: 200,
                        child: Container(
                          width: size.width * 0.7,
                          height: size.height * 0.1,
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(color: Colors.black, offset: Offset(1,1))],
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 2.5),
                              borderRadius: BorderRadius.circular(50)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    settingPressed();
                                  },
                                  child: settingOn
                                      ? Icon(Icons.settings)
                                      : Icon(Icons.settings_outlined)),
                              GestureDetector(
                                  onTap: (){
                                    homePressed();
                                  },
                                  child: mainOn
                                      ? Icon(Icons.home)
                                      : Icon(Icons.home_outlined)),
                              GestureDetector(
                                  onTap: (){
                                    suggPressed();
                                  },
                                  child: suggOn
                                      ? Icon(Icons.lightbulb)
                                      : Icon(Icons.lightbulb_outline))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
