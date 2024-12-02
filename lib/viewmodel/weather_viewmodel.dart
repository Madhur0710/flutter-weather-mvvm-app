import 'package:flutter/material.dart';
import '../model/weather_model.dart';
import '../repository/weather_repository.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository _repository = WeatherRepository();

  final List<Weather> _mockWeatherData = [
    Weather(city: "London", temperature: 22.0, description: "Sunny"),
    Weather(city: "London", temperature: 18.0, description: "Rainy"),
    Weather(city: "London", temperature: 25.0, description: "Cloudy"),
  ];

  int _currentdayIndex = 0;
  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Weather get currentWeather => _mockWeatherData[_currentdayIndex];

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _weather = await _repository.fetchWeather(city);
    } catch (e) {
      _errorMessage = 'Failed to fetch weather data. Please try again.';
    }

    _isLoading = false;
    notifyListeners();
  }

   void showPreviousDay() {
    if(_currentdayIndex > 0){
      _currentdayIndex--;
     notifyListeners();
    }
   }

   void showNextDay() {
    if(_currentdayIndex < _mockWeatherData.length - 1){
      _currentdayIndex++;
     notifyListeners();

    }
   }

}
