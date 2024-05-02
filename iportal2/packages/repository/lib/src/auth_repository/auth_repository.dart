import 'dart:async';

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
  Future<LocalLoginInfo?> getLocalLognInfo() =>
      _authLocalStorage.getLoginInfo();
  Future<String> getPassword(
      {required String numberPhone,
      required String type,
      required String password,
      required String passwordConfirmation}) async {
    final data = await _authApi.getPassword(
        numberPhone: numberPhone,
        type: type,
        password: password,
        passwordConfirmation: passwordConfirmation);
    return data;
  }

  Future<String> checkNumberPhone(
      {required String numberPhone, required String type}) async {
    final data =
        await _authApi.checkNumberPhone(numberPhone: numberPhone, type: type);
    return data;
  }

  Future<ProfileInfo> login({
    required String userName,
    required String password,
    required bool isSaveLoginInfo,
  }) async {
    try {
      final loginInfo =
          await _authApi.login(email: userName, password: password);

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

  Future<ProfileInfo> loginQR({
    required String qrCode,
    required String deviceId,
    required String model,
    required String platform,
    required String tokenFirebase,
  }) async {
    final loginInfo = await _authApi.loginQR(
        qrCode: qrCode,
        deviceId: deviceId,
        model: model,
        platform: platform,
        tokenFirebase: tokenFirebase);
    return loginInfo;
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
