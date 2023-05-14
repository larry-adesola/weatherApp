import 'package:flutter/material.dart';


class SuggScreen extends StatefulWidget {
  const SuggScreen({Key? key}) : super(key: key);

  @override
  State<SuggScreen> createState() => _SuggScreenState();
}

class _SuggScreenState extends State<SuggScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(children: [
        SizedBox(
          height: size.height * 0.175,
        ),
        Text('Suggestion')
      ]),
    );
  }
}
