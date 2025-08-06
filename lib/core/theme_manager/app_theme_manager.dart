import 'package:flutter/material.dart';

abstract class AppThemeManager{

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
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
        )
    )

  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,

  );
}