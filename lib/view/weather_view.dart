import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/weather_viewmodel.dart';

class WeatherView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  var weatherViewModel = context.watch<WeatherViewModel>(); 

    final TextEditingController cityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 ElevatedButton(
                    onPressed: weatherViewModel.showPreviousDay,
                    child: const Text('Prev Day'),
            ),
                ElevatedButton(
                 onPressed: () {
                 if (cityController.text.isNotEmpty) {
                  weatherViewModel.fetchWeather(cityController.text);
                 }
                },
                 child: const Text('Get Weather'),
            ),
                   ElevatedButton(
                    onPressed: weatherViewModel.showNextDay,
                     child: const Text('Next Day'),
            ),
              ]
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
              )
            else
              Column(
                children: [
                  Text(
                    weatherViewModel.currentWeather.city,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${weatherViewModel.currentWeather.temperature}°C',
                    style: const TextStyle(fontSize: 40),
                  ),
                  Text(
                    weatherViewModel.currentWeather.description,
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
