import 'package:bot_toast/bot_toast.dart';
import 'package:event_app/core/routes/app_routes.dart';
import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/services/loading_services.dart';
import 'package:event_app/core/theme_manager/app_theme_manager.dart';
import 'package:event_app/modules/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';

///firabase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingProvider(),
      child : const MyApp(),
    ),
  );
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    var provider = Provider.of<SettingProvider>(context);
    return MaterialApp(
      themeMode: provider.currentTheme,
      theme: AppThemeManager.lightTheme,
      darkTheme: AppThemeManager.darkTheme,
      initialRoute: PageRoutesName.initial,
      onGenerateRoute: AppRouts.onGenerateRoutes,
      debugShowCheckedModeBanner: false,
      locale: Locale(provider.currentLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: EasyLoading.init(builder: BotToastInit()),
    );
  }
}
