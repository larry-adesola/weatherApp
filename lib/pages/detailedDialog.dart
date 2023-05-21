import 'package:converter/converter.dart';

import 'package:flutter/material.dart';

class DetailedDialog {
  static final DetailedDialog _instance = DetailedDialog._internal();

  factory DetailedDialog() {
    return _instance;
  }

  DetailedDialog._internal();

  Future<void> buildDetailedDialog(BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
    print(snapshot);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("placeholder"),
          content: Column(
            children: [
              Text(
                '${Temperature(
                    snapshot.data!['main']['temp'], 'K')
                    .valueIn('C')
                    .round()} °C',
                style: const TextStyle(fontSize: 28),
              ),
            ]
          ),
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