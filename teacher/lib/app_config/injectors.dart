import 'package:core/core.dart';
import 'package:core/presentation/screens/domain/domain_saver.dart';
import 'package:local_data_source/local_data_source.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app.dart';

class Injector {
  static void init(
{      required AuthApi authApi,
  required AbstractAuthLocalStorage authLocalStorage,
  required UserApi userApi,
  required AppFetchApi appFetchApi,
  required UserLocalStorage userLocalStorage,}
  ) {
    Injection.put<DomainSaver>(DomainSaver());
    Injection.put<AuthRepository>(AuthRepository(authApi: authApi, authLocalStorage: authLocalStorage, navigatorKey: mainNavKey));
    Injection.put<UserRepository>(UserRepository(userApi: userApi, userLocalStorage: userLocalStorage));
    Injection.put<AppFetchApiRepository>(AppFetchApiRepository(appFetchApi: appFetchApi));
  }
}
