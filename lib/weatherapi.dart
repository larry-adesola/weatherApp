import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:weather_app/users.dart';
import 'package:intl/intl.dart';

class Weather {
  static final Weather _instance = Weather._internal();

  factory Weather() {
    return _instance;
  }

  Weather._internal();

  Future<Map<String, dynamic>> getWeather() async {
    final apiKey = UserInfo().getAPIkey();
    final encodedCityName = Uri.encodeComponent(UserInfo().getCity());
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$encodedCityName&appid=$apiKey';
    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return decodedResponse;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<Map<String, dynamic>> getForecast(String targetTime) async {
    if (targetTime == '') {
      throw Exception('No Preferred Time');
    }
    final apiKey = UserInfo().getAPIkey();
    final encodedCityName = Uri.encodeComponent(UserInfo().getCity());
    final url = 'https://api.openweathermap.org/data/2.5/forecast?q=$encodedCityName&appid=$apiKey';
    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final forecastList = decodedResponse['list'];

      // Parse the target time string
      final parsedTime = DateFormat('HH:mm:ss').parse(targetTime);
      final targetDateTime = DateTime(
        DateTime
            .now()
            .year,
        DateTime
            .now()
            .month,
        DateTime
            .now()
            .day,
        parsedTime.hour,
        parsedTime.minute,
        parsedTime.second,
      );

      // Find the closest matching forecast for the target time
      final closestForecast = forecastList.reduce((a, b) {
        final aTime = DateTime.fromMillisecondsSinceEpoch(a['dt'] * 1000)
            .toLocal();
        final bTime = DateTime.fromMillisecondsSinceEpoch(b['dt'] * 1000)
            .toLocal();
        final aDiff = aTime
            .difference(targetDateTime)
            .inSeconds
            .abs();
        final bDiff = bTime
            .difference(targetDateTime)
            .inSeconds
            .abs();
        return aDiff < bDiff ? a : b;
      });
      // Extract the desired weather information from the closest forecast
      return closestForecast;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}