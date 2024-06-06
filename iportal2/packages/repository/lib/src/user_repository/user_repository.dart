import 'package:core/core.dart';
import 'package:local_data_source/local_data_source.dart';
import 'package:network_data_source/network_data_source.dart';

class UserRepository {
  UserRepository({
    required UserApi userApi,
    required UserLocalStorage userLocalStorage,
  })  : _userApi = userApi,
        _userLocalStorage = userLocalStorage;

  final UserApi _userApi;
  final UserLocalStorage _userLocalStorage;

  ProfileInfo notSignedIn() {
    return ProfileInfo.notSignedIn();
  }

  Future<LocalIPortalProfile?> getLocalUser() => _userLocalStorage.getUser();

  Future<List<LocalFeatures>?> getFeatures() =>
      _userLocalStorage.getFeaturesLocal();

  Future saveUser(LocalIPortalProfile user) async {
    await _userLocalStorage.saveUser(user);
  }

  Future clearLocalUser() => _userLocalStorage.clearUser();

  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      bool isSuccess = await _userApi.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      if (isSuccess) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw ChangePasswordFailure();
    }
  }

  Future<Map<String, dynamic>?> updateStudentPhone(
      {required String phone,
      required String motherName,
      required String fatherPhone,
      required String pupilId}) async {
    try {
      final data = await _userApi.updateStudentPhone(
          phone: phone,
          fatherPhone: fatherPhone,
          motherName: motherName,
          pupilId: pupilId);
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> updateParentPhone(
      Map<String, dynamic> body, String pupilId) async {
    try {
      final data = await _userApi.updateParentPhone(body, pupilId);
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<StudentData> getProfileStudent({required String pupilId}) async {
    try {
      final resProfile = await _userApi.getProfileStudent(pupilId: pupilId);
      return resProfile;
    } catch (e) {
      throw GetStudentInfoFailure();
    }
  }

  Future<ParentData> getProfileParent({required String pupilId}) async {
    try {
      final res = await _userApi.getProfileParent(pupilId: pupilId);
      return res;
    } catch (e) {
      throw GetStudentInfoFailure();
    }
  }

  Future loginOut() async {
    try {
      await _userApi.logOut();
      await _userLocalStorage.clearUser();
    } catch (e) {
      throw LogOutFailure();
    }
  }
}
