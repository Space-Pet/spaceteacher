import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_data_source/src/user_local_storage/user_local_storage.dart';

class UserHiveStorage implements UserLocalStorage {
  late Box<LocalProfile> _userBox;

  UserHiveStorage();

  static const userBoxName = '__NHG_User_Box__';
  static const userKey = '__NGH_User_Key__';

  init() async {
    Hive.registerAdapter(LocalProfileAdapter());
    Hive.registerAdapter(LocalChildrenAdapter());
    Hive.registerAdapter(LocalUrlImageAdapter());
    Hive.registerAdapter(LocalTrainingLevelAdapter());

    _userBox = await Hive.openBox<LocalProfile>(userBoxName);
  }

  @override
  Future<LocalProfile?> getUser() async {
    return _userBox.get(userKey);
  }

  @override
  Future saveUser(LocalProfile user) async {
    await _userBox.clear();
    await _userBox.put(userKey, user);
  }

  @override
  Future clearUser() async {
    await _userBox.clear();
  }
}
