import 'package:flutter/material.dart';

import '../app_colors/app_colors_light.dart';

ThemeData get themeDataDark => ThemeData(
      fontFamily: 'Tajawal',
      primaryColor: AppColorsLight.primaryColor,
      appBarTheme: AppBarTheme(),
      colorScheme: ColorScheme.dark(),
    );
