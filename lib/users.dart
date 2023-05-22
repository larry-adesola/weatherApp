import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/weatherapi.dart';

class UserInfo {
  static final UserInfo _instance = UserInfo._internal();

  bool _onboarded = false;
  String? _location;
  int _timezone = 0;
  int _clothingScore = 0;
  final Map<String, String> _preferredTimes = {
    'Mon': '',
    'Tue': '',
    'Wed': '',
    'Thu': '',
    'Fri': '',
    'Sat': '',
    'Sun': ''
  };
  final Map<int, String> _tempToOutfit = {
    5: 'assets/icons/jacket.png',
    10: 'assets/icons/tracksuit.png',
    15: 'assets/icons/hoodie.png',
    20: 'assets/icons/jumper.png',
  };

  factory UserInfo() {
    return _instance;
  }

  UserInfo._internal();

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _onboarded = prefs.getBool('onboard') ?? false;
    _location = prefs.getString('location');
    _clothingScore = prefs.getInt('clothing') ?? 0;
    for (String day in _preferredTimes.keys) {
      _preferredTimes[day] = prefs.getString(day) ?? '';
    }
    if (_location != null) {
      setLocation(_location!);
    } else {
      setOnboard(false);
    }
  }

  String outfitChoose(double temp) {
    String outfit = 'assets/icons/tshirt.png';
    for (int key in _tempToOutfit.keys) {
      if (temp + _clothingScore <= key) {
        outfit = _tempToOutfit[key]!;
        break;
      }
    }
    return outfit;
  }

  Future<bool> setLocation(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> response = await Weather().getLocation(cityName);
    _location = '${response['name']}, ${response['sys']['country']}';
    _timezone = response['timezone'];
    prefs.setString('location', _location!);
    return true;
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

  Future<void> setOnboard(bool onboarded) async {
    final prefs = await SharedPreferences.getInstance();
    _onboarded = onboarded;
    prefs.setBool('onboard', onboarded);
  }

  String getLocation() {
    if (_location == null) {
      throw UnsupportedError("Undefined Location");
    }
    return _location!;
  }

  int getTimezone() {
    return _timezone;
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
