import 'package:flutter_weather_api_getx/constants/configs.dart';
import 'package:flutter_weather_api_getx/models/current_weather.dart';
import 'package:flutter_weather_api_getx/models/hourly_weather.dart';
import 'package:http/http.dart' as http;

var link =
    "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric";
var hourlyLink =
    "https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric";

getCurrentWeather() async {
  var result = await http.get(Uri.parse(link));
  if (result.statusCode == 200) {
    var data = currentWeatherDataFromJson(result.body.toString());
    return data;
  }
}

getHourlyWeather() async {
  var result = await http.get(Uri.parse(hourlyLink));
  if (result.statusCode == 200) {
    var data = hourlyWeatherDataFromJson(result.body.toString());
    // ignore: avoid_print
    print('Hourly Data is received');
    return data;
  }
}
