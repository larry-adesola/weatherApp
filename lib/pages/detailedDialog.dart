import 'package:flutter/material.dart';
import 'package:weather_app/weatherapi.dart';

class DetailedDialog {
  static final DetailedDialog _instance = DetailedDialog._internal();

  factory DetailedDialog() {
    return _instance;
  }

  DetailedDialog._internal();

  Future<void> buildDetailedDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("placeholder"),
          content: const Text ("placeholder"),
          actions: <Widget>[
            TextButton(
              child: const Text ("placeholder"),
              onPressed: () {
              Navigator.of(context).pop();
            },)
          ]
        );
      }
    );
  }
}