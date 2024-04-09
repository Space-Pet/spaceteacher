import 'dart:async';
import 'dart:io';

import 'package:core/common/constants/app_locale.dart';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teacher/enviroment.dart';
import 'package:teacher/resources/resources.dart';

import 'package:teacher/src/services/routes/router_services.dart';
import 'package:teacher/src/settings/injector.dart';
import 'package:teacher/src/settings/settings.dart';
import 'package:teacher/src/splash/loading_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
    Injector.init();
    Enviroment.initFlavor(EnviromentFlavor.dev);
    runApp(
      EasyLocalization(
        supportedLocales: const [AppLocale.en, AppLocale.vi],
        path: 'assets/i18n',
        fallbackLocale: AppLocale.vi,
        child: const MyApp(),
      ),
    );
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
  final settings = Injection.get<Settings>();
  Locale locale = const Locale('en', 'US');
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // _getInitialLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        title: 'Flutter Demo Teacher App',
        theme: ThemeData(
          useMaterial3: true,
        ),
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: navigatorKey.currentContext?.locale ?? context.locale,
        initialRoute: LoadingScreen.routeName,
        onGenerateRoute: _appRouter.onGenerateRoute,
        navigatorKey: navigatorKey,
      ),
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
