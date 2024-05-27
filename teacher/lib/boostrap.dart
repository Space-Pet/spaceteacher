import 'package:core/common/components/notification/show_notification.dart';
import 'package:core/common/services/firebase_notification_service.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app.dart';
import 'package:teacher/app_config/injectors.dart';
import 'package:teacher/firebase_options.dart';
import 'package:local_data_source/local_data_source.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

void bootstrap({
  required AuthApi authApi,
  required UserApi userApi,
  required AppFetchApi appFetchApi,
  required UserLocalStorage userLocalStorage,
}) async {
  Injector.init(
    authApi: authApi,
    userApi: userApi,
    appFetchApi: appFetchApi,
    userLocalStorage: userLocalStorage,
  );

  final authRepository = Injection.get<AuthRepository>();
  final userRepository = Injection.get<UserRepository>();
  final appFetchApiRepository = Injection.get<AppFetchApiRepository>();

  await FirebaseNotificationService.shared.initialize(
    showingNotification: FlutterLocalShowingNotification(),
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(TeacherApp(
    authRepository: authRepository,
    userRepository: userRepository,
    appFetchApiRepository: appFetchApiRepository,
  ));
}
