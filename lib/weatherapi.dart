import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:weather_app/users.dart';
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
  Future<Map<String, dynamic>> getForecastSuggestion(int selectedDay,int earliestHour,int latestHour) async {
    //This method will take the selected day as an int offset from today (e.g. 1 is tomorrow) and
    // return a forecast for a suggested time on that day
    final apiKey = UserInfo().getAPIkey();
    final encodedCityName = Uri.encodeComponent(UserInfo().getCity());
    final url = 'https://api.openweathermap.org/data/2.5/forecast?q=$encodedCityName&appid=$apiKey';//TODO make it hourly for better data

  Future<Map<String, dynamic>> getForecastSuggestion(int selectedDay, int earliestHour, int latestHour) async {
    final encodedCityName = Uri.encodeComponent(UserInfo().getLocation());
    final url = 'https://api.openweathermap.org/data/2.5/forecast?q=$encodedCityName&appid=$_apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    const int secondsInDay = 24* 60 * 60;
    if (response.statusCode == 200) {
      final forecastList = decodedResponse['list'];
      //print(forecastList);
      int secondsSinceEpoch = DateTime
          .now()
          .millisecondsSinceEpoch ~/ 1000;
      int startOfSelectedDay;
      int endOfSelectedDay;
      if (selectedDay == 0) {//TODO if the day selected is today, we want the suggestions to be only in the future so the code will be slightly different
        startOfSelectedDay = secondsSinceEpoch;
        endOfSelectedDay = secondsSinceEpoch - secondsSinceEpoch % secondsInDay + secondsInDay;
        earliestHour = earliestHour ~/ 2;//TODO CONSIDER CHANGING TO -=4
        latestHour = latestHour ~/ 2;
        if (secondsSinceEpoch + earliestHour > endOfSelectedDay) {
          throw Exception('Reached end of day');
        }
      }else {
        startOfSelectedDay =
            secondsSinceEpoch - secondsSinceEpoch % secondsInDay +
                selectedDay * secondsInDay;
        endOfSelectedDay = (startOfSelectedDay + secondsInDay);
      }
      //var targetDateTime = DateTime.fromMillisecondsSinceEpoch(startOfSelectedDay * 1000 + earliestHour * 3600000);
      //var closestForecast = GetClosestForecast(forecastList, targetDateTime);

      var boundedForecastList = forecastList.where((f) {
        var earliestTime = startOfSelectedDay + earliestHour *  3600;
        var latestTime = min(endOfSelectedDay,startOfSelectedDay + latestHour *  3600);
        return (f['dt'] >= earliestTime && f['dt'] <= latestTime);
      });
      var bestForecast = getBestForecast(boundedForecastList);
      print(bestForecast);
      return bestForecast;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Map<String, dynamic> getBestForecast(forecastList){
    //if (forecastList.length == 1){
    //  return forecastList;
    //}
    final bestForecast =forecastList.reduce((a,b){
      if (rankForecast(b) > rankForecast(a)){
        return b;
      }
      return a;
    });
    //print(bestForecast);
    return bestForecast;
  }

  double rankForecast(Map<String, dynamic> forecast){

    //takes in a forecast of type dictionary and returns a rank based on the weather conditions
    const double optimalTemp =283.153;//in kelvin
    double score = 0;
    double temp = forecast['main']['feels_like']+0.001;
    num tempScore =- pow (temp - optimalTemp,2.0);
    double weatherScore = WeatherData().weatherScore[forecast?['weather'][0]['main']]!;
    score += tempScore + weatherScore;
    return score;
  }


  Map<String, dynamic> getClosestForecast(forecastList, DateTime targetDateTime) {
    return forecastList.reduce((a, b) {
      final aTime = DateTime.fromMillisecondsSinceEpoch(a['dt'] * 1000).toLocal();
      final bTime = DateTime.fromMillisecondsSinceEpoch(b['dt'] * 1000).toLocal();
      final aDiff = aTime.difference(targetDateTime).inSeconds.abs();
      final bDiff = bTime.difference(targetDateTime).inSeconds.abs();
      return aDiff < bDiff ? a : b;
    });
    //print(closestForecast);
    return closestForecast;
  }
}