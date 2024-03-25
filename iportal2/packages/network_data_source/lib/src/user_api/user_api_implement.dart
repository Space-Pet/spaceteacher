import 'package:network_data_source/network_data_source.dart';
import 'package:network_data_source/src/user_api/user_api.dart';

class ChangePasswordFailure implements Exception {}

class GetProfileFailure implements Exception {}

class UpdataProfileFailure implements Exception {}

class UserApi extends AbstractUserApi {
  UserApi({required AbstractDioClient client}) : _client = client;

  final AbstractDioClient _client;

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

  Future<bool> updateProfile({
    required String phone,
    required String position,
    required String gender,
  }) async {
    try {
      final data = await _client.doHttpPut(
        url: 'api/user/update-profile',
        requestBody: {
          "phone_number": phone,
          "position": position,
          "gender": gender,
        },
      );
      if (data.containsKey('statusCode')) {
        final statusCode = data['statusCode'];
        if (statusCode is int) {
          if (statusCode == 200) {
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      print('$e');
      print('lỗi');
      throw UpdataProfileFailure();
    }
  }

  Future<ProfileInfo> getProfile() async {
    try {
      final data = await _client.doHttpGet('api/user/user-profile');

      if (data.containsKey('data')) {
        final profileData = data['data'] as Map<String, dynamic>;
        final profileInfo = ProfileInfo.fromMap(profileData);
        return profileInfo;
      } else {
        throw GetProfileFailure();
      }
    } catch (e) {
      throw GetProfileFailure();
    }
  }
}
