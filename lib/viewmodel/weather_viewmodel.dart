import 'package:flutter/material.dart';
import '../model/weather_model.dart';

import '../repository/weather_repository.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository _repository = WeatherRepository();

  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

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
}
