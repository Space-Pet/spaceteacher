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
      children: LocalChildren(
        pupil_id: user.children.pupil_id,
        user_id: user.children.user_id,
        birthday: user.children.birthday,
        school_id: user.children.school_id,
        school_name: user.children.school_name,
        class_id: user.children.class_id,
        customer_id: user.children.customer_id,
        learn_year: user.children.learn_year,
        full_name: user.children.full_name,
        user_key: user.children.user_key,
        parent_id: user.children.parent_id,
        class_name: user.children.class_name,
        url_image: LocalUrlImage(
          web: user.children.url_image.web,
          mobile: user.children.url_image.mobile,
        ),
      ),
      cap_dao_tao: LocalTrainingLevel(
          id: user.cap_dao_tao.id, name: user.cap_dao_tao.name),
    );

    await _userLocalStorage.saveUser(localUser);
  }

  Future clearLocalUser() => _userLocalStorage.clearUser();

  Future<bool> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) async {
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

  Future<Map<String, dynamic>?> updateProfileStudent(
      {required String phone,
      required String motherName,
      required String fatherPhone,
      required String pupil_id}) async {
    try {
     final data = await _userApi.updateProfile(
          phone: phone,
          fatherPhone: fatherPhone,
          motherName: motherName,
          pupil_id: pupil_id);
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<StudentData> getProfileStudent({required String pupil_id}) async {
    try {
      final resProfile = await _userApi.getProfileStudent(pupil_id: pupil_id);
      return resProfile;
    } catch (e) {
      throw GetProfileFailure();
    }
  }

  Future loginOut() async {
    try {
      await _userApi.logOut();
    } catch (e) {
      throw LogOutFailure();
    }
  }
}
