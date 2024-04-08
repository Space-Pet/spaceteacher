import 'package:network_data_source/network_data_source.dart';

class ChangePasswordFailure implements Exception {}

class GetProfileFailure implements Exception {}

class UpdataProfileFailure implements Exception {}

class UserApi extends AbstractUserApi {
  UserApi({
    required AbstractDioClient client,
    required RestApiClient authRestClient,
    required RestApiClient partnerTokenRestClient,
  })  : _client = client,
        _authRestClient = authRestClient,
        _partnerTokenRestClient = partnerTokenRestClient;

  final AbstractDioClient _client;
  final RestApiClient _authRestClient;
  final RestApiClient _partnerTokenRestClient;

  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final data = await _client.doHttpPost(
        url: 'api/user/change-password',
        requestBody: {
          "old_password": oldPassword,
          "new_password": newPassword,
          "confirm_password": confirmPassword,
        },
      );
      if (data.containsKey('statusCode')) {
        final statusCode = data['statusCode'];
        if (statusCode is int) {
          if (statusCode == 200) {
            // callback?.call();
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      throw ChangePasswordFailure();
    }
  }

  /// Chuyển sang author
  Future logOut() async {
    try {
      // final data = await _client.doHttpPost(
      //   url: '',
      // );
      // print('thai $data');
      await _client.clearToken();
    } catch (e) {
      throw LogOutFailure();
    }
  }

  Future<Map<String, dynamic>?> updateProfile(
      {required String phone,
      required String motherName,
      required String fatherPhone,
      required String pupil_id}) async {
    try {
      final data = await _client.doHttpPut(
        url: '/api/v1/member/pupil/$pupil_id',
        requestBody: {
          "mother_name": motherName,
          "phone": phone,
          "father_phone": fatherPhone,
        },
      );
      final status = data;
      return data;
    } catch (e) {
      return null;
    }
  }


  Future<StudentData> getProfileStudent({required String pupil_id}) async {
    try {
      final data = await _client.doHttpGet('/api/v1/member/pupil/$pupil_id/');

      final profileData = data['data'] as Map<String, dynamic>;
      final profileInfo = StudentData.fromMap(profileData);
      return profileInfo;
    } catch (e) {
      print('error: $e');
      throw GetProfileFailure();
    }
  }
}
