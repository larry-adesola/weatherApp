import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/pages/welcomeBase.dart';

import 'users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
          fontFamily: 'Quicksand',
          textTheme: const TextTheme(
              bodyMedium: TextStyle(fontWeight: FontWeight.w900)
          )
      ),
      debugShowCheckedModeBanner: false,
      home: const WelcomeBase(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final UserInfo _userInfo = UserInfo.getInstance();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  //Loading counter value on start
  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Loading...',
            ),
          ],
        ),
      ),
    );
  }
}
