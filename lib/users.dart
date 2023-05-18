import 'dart:convert';

import 'package:http/http.dart' as http;

class UserInfo{
  static final UserInfo _instance = UserInfo();

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

  static UserInfo getInstance() {
    return _instance;
  }

  Future<bool> setCity(String cityName) async {
    final encodedCityName = Uri.encodeComponent(cityName);
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$encodedCityName&appid=$_apiKey';
    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    if (decodedResponse['cod'] == 200) {
      _cityName = cityName;
    }
    return decodedResponse['cod'] == 200;
  }

  void setPreferredTimes(String day, String time) {
    _preferredTimes[day] = time;
  }

  void finishOnboard() {
    _onboarded = true;
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