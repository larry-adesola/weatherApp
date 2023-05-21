import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/users.dart';

class Weather {
  static final Weather _instance = Weather._internal();

  final String _apiKey = '3194812ebdac044591796f914fbabf78';

  factory Weather() {
    return _instance;
  }

  Weather._internal();

  Future<Map<String, dynamic>> getLocation(String cityName) async {
    final encodedCityName = Uri.encodeComponent(cityName);
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$encodedCityName&appid=$_apiKey';
    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to identify city');
    }
    return decodedResponse;
  }

  Future<Map<String, dynamic>> getWeather() async {
    final encodedCityName = Uri.encodeComponent(UserInfo().getLocation());
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$encodedCityName&appid=$_apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch weather data');
    }
    return decodedResponse;
  }

  Future<Map<String, dynamic>> getForecast(String targetTime) async {
    if (targetTime == '') {
      throw Exception('No Preferred Time');
    }
    final encodedCityName = Uri.encodeComponent(UserInfo().getLocation());
    final url = 'https://api.openweathermap.org/data/2.5/forecast?q=$encodedCityName&appid=$_apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch weather data');
    }
    final forecastList = decodedResponse['list'];

    // Parse the target time string
    final parsedTime = DateFormat('HH:mm:ss').parse(targetTime);
    final targetDateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      parsedTime.hour,
      parsedTime.minute,
      parsedTime.second,
    );

    return getClosestForecast(forecastList, targetDateTime);
  }

  Future<Map<String, dynamic>> getForecastSuggestion(int selectedDay, int earliestHour, int latestHour) async {
    final encodedCityName = Uri.encodeComponent(UserInfo().getLocation());
    final url = 'https://api.openweathermap.org/data/2.5/forecast?q=$encodedCityName&appid=$_apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    const int secondsInDay = 24 * 60 * 60;
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch weather data');
    }
    final forecastList = decodedResponse['list'];
    int secondsSinceEpoch = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int startOfSelectedDay;
    // int endOfSelectedDay;
    if (selectedDay == 0) {
      startOfSelectedDay = secondsSinceEpoch;
      // endOfSelectedDay = startOfSelectedDay + secondsInDay;
      earliestHour -= 3;
    } else {
      startOfSelectedDay = secondsSinceEpoch - secondsSinceEpoch % secondsInDay + selectedDay * secondsInDay;
      // endOfSelectedDay = (startOfSelectedDay + secondsInDay);
    }
    var targetDateTime = DateTime.fromMillisecondsSinceEpoch(startOfSelectedDay * 1000 + earliestHour * 3600000);
    return getClosestForecast(forecastList, targetDateTime);
  }

  Map<String, dynamic> getClosestForecast(forecastList, DateTime targetDateTime) {
    return forecastList.reduce((a, b) {
      final aTime = DateTime.fromMillisecondsSinceEpoch(a['dt'] * 1000).toLocal();
      final bTime = DateTime.fromMillisecondsSinceEpoch(b['dt'] * 1000).toLocal();
      final aDiff = aTime.difference(targetDateTime).inSeconds.abs();
      final bDiff = bTime.difference(targetDateTime).inSeconds.abs();
      return aDiff < bDiff ? a : b;
    });
  }
}
