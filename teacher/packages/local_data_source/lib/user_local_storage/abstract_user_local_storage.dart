import 'package:core/core.dart';

abstract class UserLocalStorage {
  Future saveUser(LocalTeacher user);
  Future<LocalTeacher?> getUser();
  Future clearUser();

  Future<List<LoggedUser>?> getLoggedUsers();
  Future updatePinnedAlbum(List<int> pinnedAlbumIdList, String userKey);
}
