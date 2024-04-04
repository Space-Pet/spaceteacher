import 'package:core/core.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/model/user_model.dart';
import 'package:teacher/src/settings/settings.dart';

class UserManager {
  static final UserManager _userManager = UserManager._internal();

  factory UserManager() => _userManager;

  UserManager._internal();

  static UserManager get instance => _userManager;

  UserInfo? _user;

  UserModel? _userModel;

  void removeInstance() {
    _user = null;
    _userModel = null;
  }

  Future<void> loadSession(Settings setting) async {
    try {
      _user = await setting.getUserInfoSecure();
      // if (_user != null) {
      //   Base.instance.addApiHeaders({'token': accessToken()});
      // }
    } catch (e) {
      Log.e('$e', name: 'UserManager -> loadSession() ');
    }
  }

  Future<String> accessToken() async {
    final token = await Injection.get<Settings>().getAccessTokenSecure() ?? "";

    if (_user != null && token.isNotEmpty) {
      return token;
    } else {
      return '';
    }
  }

  // String refreshToken() {
  //   if (_user != null && _user!.refreshToken != null) {
  //     return _user!.refreshToken ?? '';
  //   } else {
  //     return '';
  //   }
  // }

  Future<UserInfo?> getUser(Settings settings) async {
    await loadSession(settings);

    return _user;
  }

  Future<void> logout({
    required Settings setting,
  }) async {
    try {
      // await UserManager.instance.loadSession(setting);
      // await authRepository.

      await setting.clearAllDataSecure();
      UserManager.instance.removeInstance();
      final user = await setting.getUserInfoSecure();
      Log.prettyJson(user?.toJson() ?? {});
      Log.d('Logout success', name: 'UserManager -> logout()');
    } catch (e) {
      Log.e('$e', name: 'FunctionMapping -> _logout()');
    }
  }
}
