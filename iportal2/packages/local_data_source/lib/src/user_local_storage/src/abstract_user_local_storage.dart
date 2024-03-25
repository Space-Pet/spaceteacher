import 'models/models.dart';

abstract class UserLocalStorage {
  Future saveUser(LocalProfile user);
  Future<LocalProfile?> getUser();
  Future clearUser();
}
