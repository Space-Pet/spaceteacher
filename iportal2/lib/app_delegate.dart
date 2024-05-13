import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:iportal2/app_config/domain_saver.dart';
import 'package:iportal2/app_config/env_config_override.dart';
import 'package:iportal2/app_config/network_client_setup.dart';
import 'package:iportal2/boostrap.dart';
import 'package:iportal2/firebase_options.dart';
import 'package:local_data_source/local_data_source.dart';
import 'package:network_data_source/network_client/interceptors/authorize_interceptor.dart';
import 'package:network_data_source/network_client/interceptors/partner_token_interceptor.dart';
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
    final instanceDomainSaver = SingletonDomainSaver();

    // Not yet implemented
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Not yet implemented
    // await configureDependencies();

    AbstractDioClient networkClient = CustomDioClient(
      baseUrl: EnvironmentConfigOverride.baseUrl,
      domainSaver: instanceDomainSaver,
    );

    final AuthRestClient authRestClient = AuthRestClient(
        EnvironmentConfigOverride.baseUrl, AuthorizeInterceptor(),
        domainSaver: instanceDomainSaver);

    final PartnerTokenRestClient partnerTokenRestClient =
        PartnerTokenRestClient(
      EnvironmentConfigOverride.baseUrl,
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

    final registerNoteBookApi = RegisterNoteBookApi(
      client: networkClient,
      authRestClient: authRestClient,
      partnerTokenRestClient: partnerTokenRestClient,
    );

    final appFetchApi = AppFetchApi(
      client: networkClient,
      authRestClient: authRestClient,
      partnerTokenRestClient: partnerTokenRestClient,
    );

    final authLocalStorage = AuthHiveStorage();
    await authLocalStorage.init();
    final userLocalStorage = UserHiveStorage();
    await userLocalStorage.init();

    HttpOverrides.global = MyHttpOverrides();
    bootstrap(
      authApi: authApi,
      authLocalStorage: authLocalStorage,
      userApi: userApi,
      registerNoteBookApi: registerNoteBookApi,
      appFetchApi: appFetchApi,
      userLocalStorage: userLocalStorage,
    );
  }
}
