import 'package:local_data_source/local_data_source.dart';
import 'package:network_data_source/network_data_source.dart';

class AuthRepository {
  AuthRepository({
    required AuthApi authApi,
    required AbstractAuthLocalStorage authLocalStorage,
  })  : _authApi = authApi,
        _authLocalStorage = authLocalStorage;
  final AuthApi _authApi;
  final AbstractAuthLocalStorage _authLocalStorage;

  String userId = '';
  Future<LocalLoginInfo?> getLocalLognInfo() => _authLocalStorage.getLoginInfo();

  Future<ProfileInfo> login({
    required String userName,
    required String password,
    required bool isSaveLoginInfo,
  }) async {
    try {
      final loginInfo = await _authApi.login(email: userName, password: password);

      if (isSaveLoginInfo) {
        await _authLocalStorage.clearLoginInfo();
        await _authLocalStorage.saveLoginInfo(
          email: userName,
          password: password,
        );
      }
      return loginInfo;
    } catch (e) {
      rethrow;
    }
  }

  Future loginOut() async {
    try {
      await _authApi.logOut();
    } catch (e) {
      throw LogOutFailure();
    }
  }

  Future<bool> initApp() async {
    await _authApi.getToken();
    return _authApi.isLogin;
  }
}
