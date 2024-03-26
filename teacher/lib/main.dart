import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:teacher/src/screens/splash/view/splash_screen.dart';
import 'package:teacher/src/services/localization_services/localization_services.dart';
import 'package:teacher/src/services/routes/router_services.dart';
import 'package:teacher/src/settings/injector.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
    Injector.init();
    LocalizationServices().load();
    runApp(const MyApp());
  }, (error, stack) {
    Log.e(error);
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Teacher App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      supportedLocales: LocalizationServices.supportedLocales,
      localizationsDelegates: LocalizationServices.localizationDelegate,
      localeResolutionCallback: LocalizationServices.localeResolutionCallback,
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: _appRouter.onGenerateRoute,
      navigatorKey: navigatorKey,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
