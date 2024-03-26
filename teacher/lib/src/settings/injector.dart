import 'package:core/core.dart';
import 'package:teacher/repository/auth_repository/auth_repositories.dart';
import 'package:teacher/repository/user_repository/user_repositories.dart';
import 'package:teacher/src/settings/settings.dart';

class Injector {
  static void init() {
    Injection.put<Settings>(Settings());
    Injection.put<AuthRepository>(AuthRepositoryImp());
    Injection.put<UserRepository>(UserRepositoryImpl());
  }
}
