import 'dart:async';

import 'package:core/core.dart';
import 'package:network_data_source/src/api_path.dart';

import '../../network_data_source.dart';

class LoginFailure implements Exception {}

class GetJobListFailure implements Exception {}

class LogOutFailure implements Exception {}

class GetCellStockFailure implements Exception {}

class NoteFailure implements Exception {}

class SettingFailure implements Exception {}

class AuthApi extends AbstractAuthApi {
  AuthApi({
    required AbstractDioClient client,
  }) : _client = client;

  final AbstractDioClient _client;

  Future<String> getPassword(
      {required String numberPhone,
      required String type,
      required String password,
      required String passwordConfirmation}) async {
    throw UnimplementedError();
  }

  Future<String> checkNumberPhone(
      {required String numberPhone, required String type}) async {
    throw UnimplementedError();
  }

  Future<ProfileInfo> login({
    required String email,
    required String password,
    required String deviceId,
    required String model,
    required String platform,
    required String tokenFirebase,
  }) async {
    throw UnimplementedError();
  }

  Future<ProfileInfo> loginWith365({required String email}) async {
    try {
      final data = await _client.doHttpPost(
        url: ApiPath.loginStaff,
        requestBody: {
          'email': email,
          'login_app': 0,
        },
      );
      final dataToken = data['data'] as Map<String, dynamic>;
      final loginInfo = LoginInfo.fromMap(dataToken);
      _client.updateAccessToken(loginInfo.access_token);

      final dataUser = data['data']['info'] as Map<String, dynamic>;
      final userInfo = ProfileInfo.fromMap(dataUser);

      Log.d(userInfo);

      return userInfo;
    } catch (e) {
      Log.e('error: $e');
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
    throw UnimplementedError();
  }

  Future<bool> logOut() async {
    throw UnimplementedError();
  }

  Future getToken() async {
    await _client.getToken();
    _client.setHeader();
  }

  bool get isLogin => _client.accessToken.isNotEmpty;
}
