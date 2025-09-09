import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/modules/authentication/pages/forget_password_view.dart';
import 'package:event_app/modules/authentication/pages/login.dart';
import 'package:event_app/modules/authentication/pages/register_view.dart';
import 'package:event_app/modules/event_creation/event_creation_view.dart';
import 'package:event_app/modules/event_creation/widget/pick_event_map_screen.dart';
import 'package:event_app/modules/event_details/view_event_details.dart';
import 'package:event_app/modules/layout/layout_view.dart';
import 'package:event_app/modules/onboarding/first_settings_screen.dart';
import 'package:event_app/modules/onboarding/on_boarding_screen.dart';
import 'package:event_app/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';

abstract class AppRouts {
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case PageRoutesName.initial:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case PageRoutesName.login:
        return MaterialPageRoute(
          builder: (_) => const Login(),
          settings: settings,
        );

      case PageRoutesName.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterView(),
          settings: settings,
        );

      case PageRoutesName.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordView(),
          settings: settings,
        );

      case PageRoutesName.layout:
        return MaterialPageRoute(
          builder: (_) => const LayoutView(),
          settings: settings,
        );

      case PageRoutesName.eventCreation:
        return MaterialPageRoute(
          builder: (_) => const EventCreationView(),
          settings: settings,
        );

      case PageRoutesName.pickEventMap:
        return MaterialPageRoute(
          builder: (_) => const PickEventMapScreen(),
          settings: settings,
        );

      case PageRoutesName.editEventView:
        return MaterialPageRoute(
          builder: (_) => const ViewEventDetails(),
          settings: settings,
        );

      case PageRoutesName.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
          settings: settings,
        );

      case PageRoutesName.firstonboarding:
        return MaterialPageRoute(
          builder: (_) => const FirstSettingsScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}
