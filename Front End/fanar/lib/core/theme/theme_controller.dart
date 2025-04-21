import 'package:fanar/core/theme/app_colors/app_colors_light.dart';
import 'package:fanar/core/theme/theme_data/theme_data_dark.dart';
import 'package:fanar/core/theme/theme_data/theme_data_light.dart';
import 'package:flutter/material.dart';

class ThemeController {
  ThemeData get lightTheme => themeDataLight;
  ThemeData get darkTheme => themeDataDark;

  LinearGradient get themeGradient => AppColorsLight.lightGradient;
}
