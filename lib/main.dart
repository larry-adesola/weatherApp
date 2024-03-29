import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/pages/homeBase.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]); //stops device rotating
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
          fontFamily: 'Quicksand', textTheme: const TextTheme(bodyMedium: TextStyle(fontWeight: FontWeight.w900))),
      debugShowCheckedModeBanner: false,
      home: const LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: UserInfo().loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [Lottie.asset('assets/anims/loading.json'), const Text('Loading')],
            );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const Text('Loading Error');
          } else {
            return UserInfo().hasOnboard() ? const HomeBase() : const WelcomeBase();
          }
        },
      )),
    );
  }
}
