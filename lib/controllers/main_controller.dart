import 'package:flutter/material.dart';
import 'package:flutter_weather_api_getx/services/api_services.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  @override
  void onInit() {
    currentWeatherData = getCurrentWeather();
    super.onInit();
  }

  var isDark = false.obs;
  var currentWeatherData;

  changeTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }
}
