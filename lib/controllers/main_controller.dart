import 'package:flutter/material.dart';
import 'package:flutter_weather_api_getx/services/api_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  @override
  void onInit() async {
    await getUserLocation();
    currentWeatherData = getCurrentWeather(latitude.value, longtitude.value);
    hourlyWeatherData = getHourlyWeather(latitude.value, longtitude.value);
    super.onInit();
  }

  var isDark = false.obs;
  dynamic currentWeatherData;
  dynamic hourlyWeatherData;
  var latitude = 0.0.obs;
  var longtitude = 0.0.obs;
  var isLoaded = false.obs;

  changeTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  getUserLocation() async {
    bool isLocationEnabled;
    LocationPermission userPermission;

    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return Future.error('ຕຳແໜ່ງບໍ່ໄດ້ເປີດໃຊ້ງານ');
    }
    userPermission = await Geolocator.checkPermission();
    if (userPermission == LocationPermission.deniedForever) {
      return Future.error('ການອະນຸຍາດຖືກປະຕິເສດ ເປີດໃຊ້ງານ');
    } else if (userPermission == LocationPermission.denied) {
      userPermission = await Geolocator.requestPermission();
      if (userPermission == LocationPermission.denied) {
        return Future.error('ການອະນຸຍາດຖືກປະຕິເສດ');
      }
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      latitude.value = value.latitude;
      longtitude.value = value.longitude;
      isLoaded.value = true;
    });
  }
}
