import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:network_data_source/network_data_source.dart';

class AuthRepository {
  AuthRepository({
    required AuthApi authApi,
    required GlobalKey<NavigatorState> navigatorKey,
  })  : _authApi = authApi,
        _navigatorKey = navigatorKey;

  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthApi _authApi;

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

  Future<TeacherLoginModel?> loginWith365() async {
    String email = '';
    try {
      // final accessToken = await oauth.getAccessToken();

      // if (accessToken != null && accessToken.isNotEmpty) {
      //   final decodeRes = JwtUtils.decode(accessToken);
      //   email = await decodeRes['unique_name'] ?? '';
      // } else {
      //   final result = await oauth.login();
      //   await result.fold((l) async {
      //     Log.e(
      //       'Microsoft Authentication Failed!',
      //       name: 'auth_repositories ->  LoginWith365()',
      //     );
      //     Log.e('$l', name: 'auth_repositories ->  LoginWith365()');
      //   }, (r) async {
      //     final decodeRes = JwtUtils.decode(r.accessToken ?? '');
      //     email = await decodeRes['unique_name'] ?? '';
      //   });
      // }

      // email = 'liemlv.baria@uka.edu.vn';
      //email = 'vyntd@saigonacademy.com';
      // email = 'elearning_1@nhg.vn';
      email = 'k12.testapp@uka.edu.vn';

      if (email.isEmpty) {
        return null;
      }

      final teacherLogin = await _authApi.staffLogin(email: email);

      return teacherLogin;
    } catch (e) {
      Log.e('$e', name: "Login Error AuthRepository -> loginWith365()");
      rethrow;
    }
  }

  Future<TeacherLoginModel?> loginWithSchool(int teacherId) async {
    try {
      final teacherLogin = await _authApi.staffSchoolLogin(teacherId);

      return teacherLogin;
    } catch (e) {
      Log.e('$e', name: "Login Error AuthRepository -> loginWith365()");
      rethrow;
    }
  }

  Future<bool> logOut() async {
    try {
      final isSuccess = await _authApi.logOut();
      if (isSuccess) {}
      return isSuccess;
    } catch (_) {}
    return true;
  }

  Future<bool> initApp() async {
    await _authApi.getToken();
    return _authApi.isLogin;
  }
}
