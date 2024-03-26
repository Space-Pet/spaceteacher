import 'package:core/core.dart';
import 'package:teacher/model/user_info.dart';


import 'package:teacher/src/settings/settings.dart';

abstract class UserRepository {
  Future<void> saveUserInfo(UserInfo userInfo);
}

class UserRepositoryImpl implements UserRepository {
  final Settings settings = Injection.get<Settings>();
  @override
  Future<void> saveUserInfo(UserInfo userInfo) async {
    await settings.saveUserModel(userInfo);
  }
}
