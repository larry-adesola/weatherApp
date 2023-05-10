import 'package:flutter/material.dart';
import 'package:weather_app/pages/welcome.dart';

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
      home: Welcome(),
    );
  }
}
