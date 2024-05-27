import 'package:core/core.dart';

import '../../auth_local_storage.dart';

class AuthHiveStorage extends AbstractAuthLocalStorage {
  late Box<LocalLoginInfo> _authBox;
  AuthHiveStorage();
  static const authBoxName = "__NHG_CRM_Auth_Box__";
  static const loginInfoKey = '__NHG_CRM_Login_Info_Key__';

  init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(LocalLoginInfoAdapter());

    _authBox = await Hive.openBox<LocalLoginInfo>(authBoxName);
  }

  @override
  Future clearLoginInfo() async {
    await _authBox.clear();
  }

  @override
  Future<LocalLoginInfo?> getLoginInfo() async {
    return _authBox.get(loginInfoKey);
  }

  @override
  Future saveLoginInfo({
    required String email,
    required String password,
  }) async {
    await _authBox.put(
      loginInfoKey,
      LocalLoginInfo(email: email, password: password),
    );
  }
}
