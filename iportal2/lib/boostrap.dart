import 'package:core/common/components/notification/show_notification.dart';
import 'package:core/common/services/firebase_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app.dart';
import 'package:iportal2/firebase_options.dart';
import 'package:local_data_source/local_data_source.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

void bootstrap({
  required AuthApi authApi,
  required AbstractAuthLocalStorage authLocalStorage,
  required UserApi userApi,
  required AppFetchApi appFetchApi,
  required UserLocalStorage userLocalStorage,
}) async {
  final authRepository =
      AuthRepository(authApi: authApi, authLocalStorage: authLocalStorage);

  final userRepository =
      UserRepository(userApi: userApi, userLocalStorage: userLocalStorage);

  final appFetchApiRepository = AppFetchApiRepository(appFetchApi: appFetchApi);

  await FirebaseNotificationService.shared.initialize(
    showingNotification: FlutterLocalShowingNotification(),
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(IPortal2App(
    authRepository: authRepository,
    userRepository: userRepository,
    appFetchApiRepository: appFetchApiRepository,
  ));
}
