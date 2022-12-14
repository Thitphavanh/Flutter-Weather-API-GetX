import 'package:flutter/material.dart';
import 'package:flutter_weather_api_getx/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomThemes {
  static final lightTheme = ThemeData(
    cardColor: bgColorWhite,
    fontFamily: 'poppins',
    scaffoldBackgroundColor: bgColorWhite,
    primaryColor: Vx.gray800,
    iconTheme: const IconThemeData(
      color: Vx.gray600,
    ),
  );
  static final darkTheme = ThemeData(
    cardColor: bgColorDark.withOpacity(0.6),
    fontFamily: 'poppins',
    scaffoldBackgroundColor: bgColorDark,
    primaryColor: Vx.white,
    iconTheme: const IconThemeData(
      color: Vx.white,
    ),
  );
}
