import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:teacher/app_config/network_client_setup.dart';
import 'package:teacher/boostrap.dart';
import 'package:teacher/firebase_options.dart';
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
    initializeDateFormatting();

    // initialize domain saver
    Injection.put<DomainSaver>(DomainSaver());

    // Not yet implemented
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final instanceDomainSaver = Injection.get<DomainSaver>();

    // Not yet implemented
    // await configureDependencies();

    AbstractDioClient networkClient = CustomDioClient(
      domainSaver: instanceDomainSaver,
    );

    final AuthRestClient authRestClient = AuthRestClient(AuthorizeInterceptor(),
        domainSaver: instanceDomainSaver);

    final PartnerTokenRestClient partnerTokenRestClient =
        PartnerTokenRestClient(
      PartnerTokenInterceptor(),
      domainSaver: instanceDomainSaver,
    );

    final authApi = AuthApi(
      client: networkClient,
    );
    final userApi = UserApi(
      client: networkClient,
      authRestClient: authRestClient,
      partnerTokenRestClient: partnerTokenRestClient,
    );

    final appFetchApi = AppFetchApi(
      client: networkClient,
      authRestClient: authRestClient,
      partnerTokenRestClient: partnerTokenRestClient,
    );

    final userLocalStorage = UserHiveStorage();
    await userLocalStorage.init();

    HttpOverrides.global = MyHttpOverrides();
    bootstrap(
      authApi: authApi,
      userApi: userApi,
      appFetchApi: appFetchApi,
      userLocalStorage: userLocalStorage,
    );
  }
}
