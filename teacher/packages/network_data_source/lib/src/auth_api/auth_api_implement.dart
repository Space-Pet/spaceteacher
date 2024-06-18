import 'dart:async';

import 'package:core/core.dart';
import 'package:network_data_source/src/api_path.dart';

import '../../network_data_source.dart';

class LoginFailure implements Exception {}

class LogOutFailure implements Exception {}

class AuthApi extends AbstractAuthApi {
  AuthApi({
    required AbstractDioClient client,
  }) : _client = client;

  final AbstractDioClient _client;

  Future<TeacherLoginModel> staffLogin({required String email}) async {
    try {
      final data = await _client.doHttpPost(
        url: ApiPath.loginStaff,
        requestBody: {
          'email': email,
          'login_app': 0,
        },
      );

      final userToken = data['data']['access_token'] as String;
      _client.updateAccessToken(userToken);

      final teacherData = data['data'] as Map<String, dynamic>;
      final teacherLogin = TeacherLoginModel.fromMap(teacherData);

      return teacherLogin;
    } catch (e) {
      Log.e('error: $e');
      rethrow;
    }
  }

  Future<TeacherLoginModel> staffSchoolLogin(int teacherId) async {
    try {
      final data = await _client.doHttpPost(
        url: ApiPath.loginStaffWithSchool,
        requestBody: {
          'teacher_id': teacherId,
          'login_app': 0,
        },
      );
      
      final userToken = data['data']['access_token'] as String;
      _client.updateAccessToken(userToken);

      final teacherData = data['data'] as Map<String, dynamic>;
      final teacherLogin = TeacherLoginModel.fromMap(teacherData);

      return teacherLogin;
    } catch (e) {
      Log.e('error: $e');
      rethrow;
    }
  }

  Future<bool> logOut() async {
    try {
      final data = await _client.doHttpPost(url: '/api/v1/logout');
      final isSuccess = data['status'] == 'success';
      print('isSuccess: $isSuccess');

      if (true) {
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
