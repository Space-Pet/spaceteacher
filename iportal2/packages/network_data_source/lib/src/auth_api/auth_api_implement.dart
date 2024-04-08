import 'package:network_data_source/network_data_source.dart';

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

  Future<ProfileInfo> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await _client.doHttpPost(
        url: '/api/v1/login',
        requestBody: {"user_key": email, "password": password, "login_app": 0},
      );
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

  Future logOut() async {
    try {
      await _client.clearToken();
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
