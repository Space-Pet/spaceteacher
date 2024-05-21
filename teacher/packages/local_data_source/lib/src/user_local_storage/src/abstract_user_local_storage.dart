import 'models/models.dart';

abstract class UserLocalStorage {
  Future saveUser(LocalProfile user);
  Future<LocalProfile?> getUser();
  Future clearUser();

  Future<List<LocalFeatures>?> getFeaturesLocal();
  Future updatePinnedAlbum(List<int> pinnedAlbumIdList, String userKey);
}
