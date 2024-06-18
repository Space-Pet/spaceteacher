import 'package:core/core.dart';
import 'package:network_data_source/network_data_source.dart';

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
      await _client.clearToken();  
      _partnerTokenRestClient.clearDomain();
      _authRestClient.clearDomain();
    } catch (e) {
      throw LogOutFailure();
    }
  }
  
  Future<Map<String, dynamic>?> updateStudentPhone({
    required String phone,
    required String motherName,
    required String fatherPhone,
    required String pupilId
  }) async {
    try {
      final data = await _client.doHttpPut(
        url: '/api/v1/member/pupil/$pupilId',
        requestBody: {
          "mother_name": motherName,
          "phone": phone,
          "father_phone": fatherPhone,
        },
      );
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> updateParentPhone(
      Map<String, dynamic> body, String pupilId) async {
    try {
      final data = await _client.doHttpPut(
        url: '/api/v1/member/pupil/$pupilId/parent',
        requestBody: body,
      );
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<StudentData> getProfileStudent({required String pupilId}) async {
    try {
      final data = await _client.doHttpGet('/api/v1/member/pupil/$pupilId');
      final studentInfo = StudentData.fromMap(data['data']);
      return studentInfo;
    } catch (e) {
      throw GetStudentInfoFailure();
    }
  }

  Future<ParentData> getProfileParent({required String pupilId}) async {
    try {
      final data =
          await _client.doHttpGet('/api/v1/member/pupil/$pupilId/parent');
      final parentInfo = ParentData.fromMap(data['data']);
      return parentInfo;
    } catch (e) {
      throw GetParentInfoFailure();
    }
  }
}

class ChangePasswordFailure implements Exception {}

class GetStudentInfoFailure implements Exception {}

class GetParentInfoFailure implements Exception {}

class UpdataProfileFailure implements Exception {}
