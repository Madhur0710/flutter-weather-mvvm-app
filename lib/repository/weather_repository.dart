import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/weather_model.dart';

class WeatherRepository {

  final String _apiKey = dotenv.env['API_KEY']!;
  final String _baseUrl = dotenv.env['BASE_URL']!;
  
  Future<Weather> fetchWeather(String city) async {
    final response = await http.get(Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric'));

    if(response.statusCode == 200){
      final data = json.decode(response.body);
      return Weather.fromJson(data);
      }else{
        throw Exception('Failed to load weather data');
      }

  }

}
