import 'package:core/core.dart';
import 'package:local_data_source/local_data_source.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app.dart';

class Injector {
  static void init({
    required AuthApi authApi,
    required UserApi userApi,
    required AppFetchApi appFetchApi,
    required UserLocalStorage userLocalStorage,
  }) {
    Injection.put<AuthRepository>(
        AuthRepository(authApi: authApi, navigatorKey: mainNavKey));
    Injection.put<UserRepository>(
        UserRepository(userApi: userApi, userLocalStorage: userLocalStorage));
    Injection.put<AppFetchApiRepository>(
        AppFetchApiRepository(appFetchApi: appFetchApi));
  }
}
