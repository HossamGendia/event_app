import 'package:flutter/material.dart';

import 'color_pallete.dart';

abstract class AppThemeManager {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.appBarTitleColor,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontFamily: "Inter",
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Inter",
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(scaffoldBackgroundColor: Colors.white);
}
