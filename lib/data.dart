class WeatherData {
  Map<String, String> weatherIcons = {
    'Clouds': 'assets/icons/clouds.png',
    'Drizzle': 'assets/icons/rain.png',
    'Rain': 'assets/icons/rain.png',
    'Clear': 'assets/icons/clear.png',
    'Thunderstorm': 'assets/icons/thunder.png',
    'Snow': 'assets/icons/snow.png',
    'Mist': 'assets/icons/mist.png'
  };
  Map<String, double> weatherScore = {
    'Clouds': 0,
    'Drizzle' : -4,
    'Rain' : -12,
    'Clear' : 10,
    'Thunderstorm': -20,
    'Snow' : -15,
    'Mist' : -3
  };
}
