import 'package:flutter/material.dart';
import 'package:fake_meteo/components/city_weather.dart';
import 'package:fake_meteo/model/city_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: weatherData.length,
        itemBuilder: (context, index) => CityWeather(
          weatherData[index],
        ),
      ),
    );
  }
}
