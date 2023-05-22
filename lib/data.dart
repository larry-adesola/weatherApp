class WeatherData {
  static final WeatherData _instance = WeatherData._internal();

  factory WeatherData() {
    return _instance;
  }

  WeatherData._internal();

  final Map<String, String> _weatherIcons = {
    'Clouds': 'assets/icons/clouds.png',
    'Drizzle': 'assets/icons/rain.png',
    'Rain': 'assets/icons/rain.png',
    'Clear': 'assets/icons/clear.png',
    'Thunderstorm': 'assets/icons/thunder.png',
    'Snow': 'assets/icons/snow.png',
    'Atmosphere': 'assets/icons/atmosphere.png',
  };
  final Map<String, double> _weatherScore = {
    'Clouds': 0,
    'Drizzle': -4,
    'Rain': -12,
    'Clear': 10,
    'Thunderstorm': -20,
    'Snow': -15,
    'Atmosphere': -25,
  };

  String getWeatherIcon(String condition) {
    return _weatherIcons[condition] ?? _weatherIcons['Atmosphere']!;
  }

  double getWeatherScore(String condition) {
    return _weatherScore[condition] ?? _weatherScore['Atmosphere']!;
  }
}
