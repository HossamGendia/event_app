import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/services/local_storage_keys.dart';
import 'package:event_app/core/services/local_storage_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/constants/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigate();
    });
  }

  void _navigate() async {
    final hasSeenOnboarding =
        LocalStorageServices.getBool(LocalStorageKeys.onboardingSeenKey) ??
        false;
    await Future.delayed(Duration(seconds: 2));

    if (!mounted) return;

    final user = FirebaseAuth.instance.currentUser;

    if (!hasSeenOnboarding) {
      Navigator.pushReplacementNamed(context, PageRoutesName.firstonboarding);
    } else if (user == null) {
      Navigator.pushReplacementNamed(context, PageRoutesName.login);
    } else {
      Navigator.pushReplacementNamed(context, PageRoutesName.layout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [Image.asset(Assets.eventLogo, height: 185)],
      ),
    );
  }
}
