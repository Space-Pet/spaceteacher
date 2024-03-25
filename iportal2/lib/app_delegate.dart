import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iportal2/app_config/network_client_setup.dart';
import 'package:iportal2/app_config/env_config.dart';
import 'package:iportal2/boostrap.dart';
import 'package:local_data_source/local_data_source.dart';
import 'package:network_data_source/network_data_source.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class AppDelegate {
  static Future<dynamic> run() async {
    WidgetsFlutterBinding.ensureInitialized();

    // await SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);

    // Not yet implemented
    // Config.instance.setup(env);

    await Hive.initFlutter();

    // Not yet implemented
    // await Firebase.initializeApp();

    // Not yet implemented
    // await configureDependencies();

    AbstractDioClient networkClient = CustomDioClient(
      baseUrl: EnvironmentConfig.baseUrl,
    );

    final authApi = AuthApi(
      client: networkClient,
    );
    final userApi = UserApi(
      client: networkClient,
    );
    final jobApi = JobApi(
      client: networkClient,
    );
    final authLocalStorage = AuthHiveStorage();
    await authLocalStorage.init();
    final userLocalStorage = UserHiveStorage();
    await userLocalStorage.init();

    // return runZonedGuarded(() async {
    //   runApp(const IPortal2App());
    // }, (Object error, StackTrace stack) {
    //   LogUtils.e('Error from runZonedGuarded', error, stack);

    //   // Not yet implemented
    //   // FirebaseCrashlytics.instance.recordError(error, stack);
    // });
    HttpOverrides.global = MyHttpOverrides();
    bootstrap(
      authApi: authApi,
      authLocalStorage: authLocalStorage,
      userApi: userApi,
      jobApi: jobApi,
      userLocalStorage: userLocalStorage,
    );
  }
}
