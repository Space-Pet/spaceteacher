import 'package:core/core.dart';
import 'package:teacher/model/user_info.dart';

import 'package:teacher/src/settings/settings.dart';

abstract class UserRepository {
  Future<void> saveUserInfo(UserInfo userInfo);
  Future<UserInfo> getUserInfo();
}

class UserRepositoryImpl implements UserRepository {
  final Settings settings = Injection.get<Settings>();
  @override
  Future<void> saveUserInfo(UserInfo userInfo) async {
    await settings.saveUserModel(userInfo);
  }

  @override
  Future<UserInfo> getUserInfo() async {

    final Settings settings = Injection.get<Settings>();

    return await settings.getUserInfoSecure() ?? UserInfo();
  }
}
