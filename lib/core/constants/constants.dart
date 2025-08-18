import 'package:event_app/modules/layout/sub_modules/favorite/favorite_view.dart';
import 'package:event_app/modules/layout/sub_modules/home/home_view.dart';
import 'package:event_app/modules/layout/sub_modules/profile/profile_view.dart';
import 'package:flutter/material.dart';
import '../../modules/layout/sub_modules/maps/maps_view.dart';

abstract class Constants{
  static List<Widget> screens =
  [
    HomeView(),
    MapsView(),
    FavoriteView(),
    ProfileView(),
  ];

}