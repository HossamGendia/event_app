import 'package:event_app/core/theme_manager/color_pallete.dart' show AppColors;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart' show EasyLoading, EasyLoadingIndicatorType, EasyLoadingStyle;

void configLoading() {
  EasyLoading.instance
    //..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    //..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..textColor = Colors.yellow
    ..indicatorColor = AppColors.primaryColor
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}