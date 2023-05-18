import 'package:flutter/material.dart';
import 'package:weather_app/pages/mainScreen.dart';
import 'package:weather_app/pages/settingsScreen.dart';
import 'package:weather_app/pages/suggestionScreen.dart';

import '../users.dart';

final GlobalKey<_HomeBaseState> homeBaseKey = GlobalKey<_HomeBaseState>();


class HomeBase extends StatefulWidget {
  UserInfo userInfo;
  HomeBase({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<HomeBase> createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> {
  int _selectedIndex = 0; // 0 -> Main, 1 -> Suggestions, 2 -> Settings

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          MainScreen(),
          SuggScreen(),
          SettingScreen(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0), ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_run),
              label: 'Suggestions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn);
          },
        ),
      ),
    );
  }
}
