import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SuggScreen extends StatefulWidget {
  const SuggScreen({Key? key}) : super(key: key);


  @override
  State<SuggScreen> createState() => _SuggScreenState();
}

class _SuggScreenState extends State<SuggScreen> {
  int _selectedDay = 0; //current day is selected by default
  final String currentDay = DateFormat('EEE').format(DateTime.now());
  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final currentDayIndex = days.indexOf(currentDay);

    return (
        Positioned(
            top: 25,
            left: 25,
            child: ButtonBar(
                children: [
                  OutlinedButton(
                      onPressed: () {
                        _selectedDay = 0;
                      },
                      child: Text(
                          currentDay,
                          style: TextStyle(color: Colors.black)
                      )
                  ),
                  OutlinedButton(
                      onPressed: () {
                        _selectedDay = 1;
                      },
                      child: Text(days[(currentDayIndex + 1) % 7],
                          style: TextStyle(color: Colors.black))
                  ),
                  OutlinedButton(
                      onPressed: () {
                        _selectedDay = 2;
                      },
                      child: Text(days[(currentDayIndex + 2) % 7],
                          style: const TextStyle(color: Colors.black))

                  ),
                  OutlinedButton(
                      onPressed: () {
                        _selectedDay = 3;
                      },
                      child: Text(days[(currentDayIndex + 3) % 7],
                          style: const TextStyle(color: Colors.black)))
                ]
            )
        )
    );
  }
}
  