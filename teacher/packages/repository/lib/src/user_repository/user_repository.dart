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

  Future<ProfileInfo?> getLocalUser() async {
    final localUser = await _userLocalStorage.getUser();

    if (localUser == null) return null;

    return ProfileInfo.fromLocalUser(localProfile: localUser);
  }

  Future<List<LocalFeatures>?> getFeatures() async {
    final localFeatures = await _userLocalStorage.getFeaturesLocal();

    if (localFeatures == null) return null;

    return localFeatures;
  }

  Future updatePinnedAlbum(List<int> pinnedAlbumIdList, String userKey) async {
    await _userLocalStorage.updatePinnedAlbum(pinnedAlbumIdList, userKey);
  }

  Future saveUser(ProfileInfo user) async {
    final localUser = LocalProfile(
      name: user.name,
      user_key: user.user_key,
      user_id: user.user_id,
      school_id: user.school_id,
      pupil_id: user.pupil_id,
      type: user.type,
      type_text: user.type_text,
      parent_id: user.parent_id,
      parent_name: user.parent_name,
      father_name: user.father_name,
      learn_year: user.learn_year,
      class_name: user.class_name,
      school_name: user.school_name,
      school_logo: user.school_logo,
      school_brand: user.school_brand,
      semester: user.semester,
      features: user.features,
      pinnedAlbumIdList: user.pinnedAlbumIdList,
      background: user.background,
      email: user.email,
    );

    await _userLocalStorage.saveUser(localUser);
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

  Future<void> loginOut() async {
    try {
      await _userApi.logOut();
      await _userLocalStorage.clearUser();
    } catch (_) {}
  }
}
