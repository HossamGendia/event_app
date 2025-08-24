import 'package:flutter/material.dart';

import 'color_pallete.dart';

abstract class AppThemeManager {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.primaryColor,
      selectedIconTheme: IconThemeData(color: Colors.white),
      unselectedIconTheme: IconThemeData(color: Colors.white),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      selectedLabelStyle: TextStyle(
          fontFamily: "Inter",
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.white
      ),
      unselectedLabelStyle: TextStyle(
          fontFamily: "Inter",
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.white
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Inter",
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),

      bodyLarge: TextStyle(
        fontFamily: "Inter",
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Inter",
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: "Inter",
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Colors.white
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(scaffoldBackgroundColor: Colors.white);
}
