import 'package:flutter/material.dart';

import '../app_colors/app_colors_light.dart';

ThemeData get themeDataLight => ThemeData(
  fontFamily: 'Tajawal',
  primaryColor: AppColorsLight.primaryColor,
  appBarTheme: AppBarTheme(),
  colorScheme: ColorScheme.light().copyWith(
    primary: AppColorsLight.primaryColor,
  ),
  scaffoldBackgroundColor: AppColorsLight.scaffoldBackgroundColor,
);
