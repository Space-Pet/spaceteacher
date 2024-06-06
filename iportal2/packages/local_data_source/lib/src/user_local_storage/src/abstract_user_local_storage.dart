import 'package:core/core.dart';

abstract class UserLocalStorage {
  Future saveUser(LocalIPortalProfile user);
  Future<LocalIPortalProfile?> getUser();
  Future clearUser();
  Future<List<LocalFeatures>?> getFeaturesLocal();
}
