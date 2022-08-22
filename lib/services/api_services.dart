import 'package:flutter_weather_api_getx/constants/configs.dart';
import 'package:flutter_weather_api_getx/models/current_weather.dart';
import 'package:http/http.dart' as http;

var link =
    "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric";

getCurrentWeather() async {
  var result = await http.get(Uri.parse(link));
  if (result.statusCode == 200) {
    var data = currentWeatherDataFromJson(result.body.toString());
    print('Data is received');
    return data;
  }
}
