import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo{
  static final UserInfo _instance = UserInfo._internal();

  final String _apiKey = '3194812ebdac044591796f914fbabf78';

  bool _onboarded = false;
  String? _cityName;
  final Map<String, String> _preferredTimes = {
    'monday': '',
    'tuesday': '',
    'wednesday': '',
    'thursday': '',
    'friday': '',
    'saturday': '',
    'sunday': ''
  };

  factory UserInfo() {
    return _instance;
  }

  UserInfo._internal();

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _onboarded = prefs.getBool('onboard') ?? false;
    _cityName = prefs.getString('city');
    for (String day in _preferredTimes.keys) {
      _preferredTimes[day] = prefs.getString(day) ?? '';
    }
  }

  Future<bool> setCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedCityName = Uri.encodeComponent(cityName);
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$encodedCityName&appid=$_apiKey';
    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    if (decodedResponse['cod'] == 200) {
      _cityName = cityName;
      prefs.setString('city', cityName);
    }
    return decodedResponse['cod'] == 200;
  }

  Future<void> setPreferredTimes(String day, String time) async {
    final prefs = await SharedPreferences.getInstance();
    _preferredTimes[day] = time;
    prefs.setString(day, time);
  }

  Future<void> finishOnboard() async {
    final prefs = await SharedPreferences.getInstance();
    _onboarded = true;
    prefs.setBool('onboard', true);
  }

  String getAPIkey() {
    return _apiKey;
  }

  String getCity() {
    if (_cityName == null) {
      throw UnsupportedError("Invalid City");
    }
    return _cityName!;
  }

  Map<String, String> getPreferredTimes() {
    return _preferredTimes;
  }

  bool hasOnboard() {
    return _onboarded;
  }
}