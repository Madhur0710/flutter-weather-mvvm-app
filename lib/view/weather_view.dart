import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/weather_viewmodel.dart';

class WeatherView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  var weatherViewModel = context.watch<WeatherViewModel>(); // Use context.watch()

    final TextEditingController cityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (cityController.text.isNotEmpty) {
                  weatherViewModel.fetchWeather(cityController.text);
                }
              },
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 16),
            if (weatherViewModel.isLoading)
              const CircularProgressIndicator()
            else if (weatherViewModel.errorMessage != null)
              Text(
                weatherViewModel.errorMessage!,
                style: const TextStyle(color: Colors.red),
              )
            else if (weatherViewModel.weather != null)
              Column(
                children: [
                  Text(
                    weatherViewModel.weather!.city,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${weatherViewModel.weather!.temperature}°C',
                    style: const TextStyle(fontSize: 40),
                  ),
                  Text(
                    weatherViewModel.weather!.description,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
