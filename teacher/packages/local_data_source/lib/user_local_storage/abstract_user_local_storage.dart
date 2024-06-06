import 'package:core/core.dart';

abstract class UserLocalStorage {
  Future saveUser(LocalTeacher user);
  Future<LocalTeacher?> getUser();
  Future clearUser();
}
