import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  static final UserInfo _instance = UserInfo._internal();

  final String _apiKey = '3194812ebdac044591796f914fbabf78';
  bool _onboarded = false;
  String? _cityName;
  int _clothingScore  = 0;
  final Map<String, String> _preferredTimes = {
    'Mon': '',
    'Tue': '',
    'Wed': '',
    'Thu': '',
    'Fri': '',
    'Sat': '',
    'Sun': ''
  };
  //can use key transformation stuff for the clothes addjusment thing
  //also the temperature must be equal to or lower than
  final Map<double, String> _tempToOutfit = {
    5: 'assets/icons/jacket.png',
    10: 'assets/icons/tracksuit.png',
    15: 'assets/icons/hoodie.png',
    20: 'assets/icons/jumper.png',
  };


  factory UserInfo() {
    return _instance;
  }

  String outfitChoose(int temp){
    String outfit = 'assets/icons/tshirt.png';
    bool stop = false;
    _tempToOutfit.forEach((key, value) {
      if(temp<=key && !stop){
        print(value);
        outfit = value;
        stop = true;
      }
    });
    return outfit;

  }

  UserInfo._internal();

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _onboarded = prefs.getBool('onboard') ?? false;
    _cityName = prefs.getString('city');
    _clothingScore = prefs.getInt('clothing') ?? 0;
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
      final nameOfCity = decodedResponse['name'];
      final countryOfCity = decodedResponse['sys']['country'];
      final city = "$nameOfCity, $countryOfCity";
      _cityName = city;
      prefs.setString('city', city);
    }
    return decodedResponse['cod'] == 200;
  }

  Future<void> setClothingScore(int clothingScore) async {
    final prefs = await SharedPreferences.getInstance();
    _clothingScore = clothingScore;
    prefs.setInt('clothing', clothingScore);
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

  int getClothingScore() {
    return _clothingScore;
  }

  Map<String, String> getPreferredTimes() {
    return Map.from(_preferredTimes);
  }

  bool hasOnboard() {
    return _onboarded;
  }
}