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

  TeacherLogin notSignedIn() {
    return TeacherLogin.empty();
  }

  Future saveUser(LocalTeacher user) async {
    await _userLocalStorage.saveUser(user);
  }

  Future<LocalTeacher?> getLocalUser() async {
    final localUser = await _userLocalStorage.getUser();
    if (localUser == null) return null;

    return localUser;
  }

  Future<TeacherDetail> getTeacherDetail(String teacherId) async {
    try {
      final resProfile = await _userApi.getTeacherDetail(teacherId);
      return resProfile;
    } catch (e) {
      throw GetTeacherInfoFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await _userApi.logOut();
      await _userLocalStorage.clearUser();
    } catch (_) {}
  }
}
