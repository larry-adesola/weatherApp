import 'package:flutter/material.dart';
import 'package:flutter_scale_ruler/flutter_scale_ruler.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ScaleValue? _scaleValue;
  //ScaleValue? _scaleValueCms;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(children: [
        SizedBox(
          height: size.height * 0.175,
        ),
        Text('Settings'),
        Text("Clothing recommendation adjustment"),
        Text(
          "${_scaleValue?.feet ?? "0"} Feet",
          style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 20.0,
          ),
        ScaleRuler.lengthMeasurement(
          maxValue: 8,
          minValue: 2,
          isFeet: true,
          stepIndicatorColor: Colors.brown,
          stepIndicatorDividerColor: Colors.blue,
          onChanged: (ScaleValue? scaleValue) {
            setState(() {
              _scaleValue = scaleValue;
            });
          }),
        ]),
    );
  }
}
