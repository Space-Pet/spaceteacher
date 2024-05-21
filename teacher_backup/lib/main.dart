import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teacher/enviroment.dart';

import 'package:teacher/src/services/routes/router_services.dart';
import 'package:teacher/src/settings/injector.dart';
import 'package:teacher/src/splash/loading_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await dotenv.load(fileName: '.env');
    await Hive.initFlutter();
    HttpOverrides.global = MyHttpOverrides();
    Injector.init();
    Enviroment.initFlavor(EnviromentFlavor.dev);
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('vi', 'VN'), Locale('en', 'US')],
        path: 'assets/i18n',
        fallbackLocale: const Locale('vi', 'VN'),
        startLocale: const Locale('vi', 'VN'),
        child: const CreateApp(),
      ),
    );
  }, (error, stack) {
    Log.e(error);
  });
}

class CreateApp extends StatelessWidget {
  const CreateApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        theme: ThemeData(useMaterial3: true),
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: navigatorKey.currentContext?.locale ?? context.locale,
        initialRoute: LoadingScreen.routeName,
        onGenerateRoute: AppRouter().onGenerateRoute,
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
