import 'dart:async';

import 'package:core/core.dart' hide LoginInfo;
import 'package:network_data_source/network_data_source.dart';

class LoginFailure implements Exception {
  LoginFailure({this.message});
  final String? message;
}

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
    try {
      final data =
          await _client.doHttpPost(url: '/api/v1/get_password', requestBody: {
        "phone_number": numberPhone,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "entity_type": type
      });
      return data['message'];
    } catch (e) {
      return 'Lỗi hệ thống';
    }
  }

  Future<String> checkNumberPhone(
      {required String numberPhone, required String type}) async {
    try {
      final data = await _client.doHttpPost(
          url: '/api/v1/phone-validate',
          requestBody: {"phone_number": numberPhone, "entity_type": type});
      final message = data['message'];
      return message;
    } catch (e) {
      return 'Lỗi hệ thống';
    }
  }

  Future<ProfileInfo> login({
    required String email,
    required String password,
    required String deviceId,
    required String model,
    required String platform,
    required String tokenFirebase,
  }) async {
    try {
      final data = await _client.doHttpPost(
        url: '/api/v1/login',
        requestBody: {
          "user_key": email,
          "password": password,
          "login_app": 0,
          "device_id": deviceId,
          "model": model,
          "platform": platform,
          "token_firebase": tokenFirebase,
        },
      );

      // Response fail
      // {
      //   "status": "fail",
      //   "message": "Mật khẩu hoặc tài khoản không đúng",
      //   "code": 201,
      //   "data": []
      // }
      final status = data['status'] as String?;
      if (status == 'fail') {
        final message = data['message'] as String?;
        throw LoginFailure(message: message);
      }

      final dataToken = data['data'] as Map<String, dynamic>;
      final loginInfo = LoginInfo.fromMap(dataToken);
      _client.updateAccessToken(loginInfo.access_token);

      final dataUser = data['data']['info'] as Map<String, dynamic>;
      final userInfo = ProfileInfo.fromMap(dataUser);

      Log.d('login: userInfo:');
      Log.d(userInfo.toMap());

      return userInfo;
    } catch (e) {
      print('error: $e');
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
    try {
      final data =
          await _client.doHttpPost(url: '/api/v1/login-QRCode', requestBody: {
        "qrcode": qrCode,
        "device_id": deviceId,
        "model": model,
        "platform": platform,
        "token_firebase": tokenFirebase
      });
      final dataToken = data['data'] as Map<String, dynamic>;
      final loginInfo = LoginInfo.fromMap(dataToken);
      _client.updateAccessToken(loginInfo.access_token);

      final dataUser = data['data']['info'] as Map<String, dynamic>;
      final userInfo = ProfileInfo.fromMap(dataUser);

      return userInfo;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  Future<bool> logOut() async {
    try {
      final data = await _client.doHttpPost(url: '/api/v1/logout');
      final isSuccess = data['status'] == 'success';
      print('isSuccess: $isSuccess');

      if (isSuccess) {
        await _client.clearToken();
      }
      return isSuccess;
    } catch (e) {
      throw LogOutFailure();
    }
  }

  Future getToken() async {
    await _client.getToken();
    _client.setHeader();
  }

  bool get isLogin => _client.accessToken.isNotEmpty;
}
