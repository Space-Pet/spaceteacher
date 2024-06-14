import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/domain_saver.dart';
import 'package:iportal2/app_config/network_client_setup.dart';
import 'package:iportal2/boostrap.dart';
import 'package:iportal2/firebase_options.dart';
import 'package:local_data_source/local_data_source.dart';
import 'package:network_data_source/network_data_source.dart';

class AppDelegate {
  static Future<dynamic> run() async {
    WidgetsFlutterBinding.ensureInitialized();

    // await SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);


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
