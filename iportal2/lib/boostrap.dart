import 'package:flutter/material.dart';
import 'package:iportal2/app.dart';
import 'package:local_data_source/local_data_source.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

void bootstrap({
  required AuthApi authApi,
  required AbstractAuthLocalStorage authLocalStorage,
  required UserApi userApi,
  required JobApi jobApi,
  required RegisterNoteBookApi registerNoteBookApi,
  required AppFetchApi appFetchApi,
  required UserLocalStorage userLocalStorage,
}) {
  final authRepository =
      AuthRepository(authApi: authApi, authLocalStorage: authLocalStorage);

  final userRepository =
      UserRepository(userApi: userApi, userLocalStorage: userLocalStorage);

  final jobRepository = JobRepository(jobApi: jobApi);

  final registerNoteBookRepository =
      RegisterNotebookRepository(registerNoteBookApi: registerNoteBookApi);

  final appFetchApiRepository = AppFetchApiRepository(appFetchApi: appFetchApi);

  runApp(IPortal2App(
    authRepository: authRepository,
    userRepository: userRepository,
    jobRepository: jobRepository,
    registerRepository: registerNoteBookRepository,
    appFetchApiRepository: appFetchApiRepository,
  ));
}
