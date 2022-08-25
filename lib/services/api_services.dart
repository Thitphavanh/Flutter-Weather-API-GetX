import 'package:flutter_weather_api_getx/constants/configs.dart';
import 'package:flutter_weather_api_getx/models/current_weather.dart';
import 'package:flutter_weather_api_getx/models/hourly_weather.dart';
import 'package:http/http.dart' as http;

getCurrentWeather(lat, long) async {
  var link =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric";
  var result = await http.get(Uri.parse(link));
  if (result.statusCode == 200) {
    var data = currentWeatherDataFromJson(result.body.toString());
    print('Current Data is recived');
    return data;
  }
}

getHourlyWeather(lat, long) async {
  var link =
      "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKey&units=metric";
  var result = await http.get(Uri.parse(link));
  if (result.statusCode == 200) {
    var data = hourlyWeatherDataFromJson(result.body.toString());
    print('Hourly Data is recived');
    return data;
  }
}
