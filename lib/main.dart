import 'package:event_app/core/routes/app_routes.dart';
import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/theme_manager/app_theme_manager.dart';
import 'package:flutter/material.dart';

///firabase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeManager.lightTheme,
      //themeMode: AppThemeManager.lightTheme,
      darkTheme: AppThemeManager.darkTheme,
      initialRoute: PageRoutesName.initial,
      onGenerateRoute: AppRouts.onGenerateRoutes,
    );
  }
}
