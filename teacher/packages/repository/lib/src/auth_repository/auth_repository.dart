import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:local_data_source/local_data_source.dart';
import 'package:network_data_source/network_data_source.dart';

import '../../repository.dart';

class AuthRepository {
  AuthRepository({
    required AuthApi authApi,
    required AbstractAuthLocalStorage authLocalStorage,
    required GlobalKey<NavigatorState> navigatorKey,
  })  : _authApi = authApi,
        _authLocalStorage = authLocalStorage,
        _navigatorKey = navigatorKey;

  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthApi _authApi;
  final AbstractAuthLocalStorage _authLocalStorage;

  String userId = '';
  Future<LocalLoginInfo?> getLocalLognInfo() =>
      _authLocalStorage.getLoginInfo();

  AadOAuth get oauth {
    const String redirectUri = 'https://test-iportal.nhg.vn/callback365.php';
    const String clientId = '62325d54-51d5-4eda-9d2c-bf27862db766';
    const String tenant = '5a574f72-e36a-41cd-bdb3-009cbcd57086';
    const String clientScr = 'cd-8Q~lkUxf3cz9vA6EdeTUMyQs6jvPc7sVjlaYu';

    final Config config = Config(
      tenant: tenant,
      clientId: clientId,
      scope: 'openid profile offline_access',
      redirectUri: redirectUri,
      responseType: 'code',
      clientSecret: clientScr,
      navigatorKey: _navigatorKey,
    );

    return AadOAuth(config);
  }

  Future<ProfileInfo?> loginWith365() async {
    String email = '';
    try {
      final accessToken = await oauth.getAccessToken();

      if (accessToken != null && accessToken.isNotEmpty) {
        final decodeRes = JwtUtils.decode(accessToken);
        email = await decodeRes['unique_name'] ?? '';
      } else {
        final result = await oauth.login();
        await result.fold((l) async {
          Log.e(
            'Microsoft Authentication Failed!',
            name: 'auth_repositories ->  LoginWith365()',
          );
          Log.e('$l', name: 'auth_repositories ->  LoginWith365()');
        }, (r) async {
          final decodeRes = JwtUtils.decode(r.accessToken ?? '');
          email = await decodeRes['unique_name'] ?? '';
        });
      }

      if (email.isEmpty) {
        return null;
      }

      final loginInfo = await _authApi.loginWith365(email: email);

      await _authLocalStorage.clearLoginInfo();

      await _authLocalStorage.saveLoginInfo(
        email: email,
        password: '',
      );
      return loginInfo;
    } catch (e) {
      Log.e('$e', name: "Login Error AuthRepository -> loginWith365()");
      rethrow;
    }
  }

  Future<String> getPassword(
      {required String numberPhone,
      required String type,
      required String password,
      required String passwordConfirmation}) async {
    throw UnimplementedError();
  }

  Future<String> checkNumberPhone({
    required String numberPhone,
    required String type,
  }) async {
    throw UnimplementedError();
  }

  Future<ProfileInfo> login({
    required String userName,
    required String password,
    required String deviceId,
    required String model,
    required String platform,
    required String tokenFirebase,
  }) async {
    try {
      final loginInfo = await _authApi.login(
        email: userName,
        password: password,
        deviceId: deviceId,
        model: model,
        platform: platform,
        tokenFirebase: tokenFirebase,
      );

      await _authLocalStorage.clearLoginInfo();
      await _authLocalStorage.saveLoginInfo(
        email: userName,
        password: password,
      );
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

  Future<bool> logOut() async {
    try {
      final isSuccess = await _authApi.logOut();
      if (isSuccess) {
        await _authLocalStorage.clearLoginInfo();
      }
      return isSuccess;
    } catch (_) {}
    return true;
  }

  Future<bool> initApp() async {
    await _authApi.getToken();
    return _authApi.isLogin;
  }

  Future<PhoneNumberVerificationInfo?> sendOTP(String phoneNumber) async {
    throw UnimplementedError();
  }

  Future<PhoneNumberVerificationInfo?> resendOTP(
    String phoneNumber,
    int? forceResendingToken,
  ) async {
    throw UnimplementedError();
  }

  Future verifyOTP(String verificationId, String otp) async {
    throw UnimplementedError();
  }
}
