import 'package:core/core.dart';
import 'package:local_data_source/local_data_source.dart';
import 'package:local_data_source/src/user_local_storage/user_local_storage.dart';

class UserHiveStorage implements UserLocalStorage {
  late Box<LocalIPortalProfile> _userBox;

  UserHiveStorage();

  static const userBoxName = '__NHG_User_Box__';
  static const userKey = '__NGH_User_Key__';

  init() async {
    Hive.registerAdapter(LocalIPortalProfileAdapter());
    Hive.registerAdapter(LocalChildrenAdapter());
    Hive.registerAdapter(LocalTrainingLevelAdapter());
    Hive.registerAdapter(LocalFeaturesAdapter());
    Hive.registerAdapter(LocalUrlImageAdapter());

    Hive.registerAdapter(FeatureModelAdapter());
    Hive.registerAdapter(FeatureKeyAdapter());
    Hive.registerAdapter(FeatureCategoryAdapter());
    Hive.registerAdapter(FeatureGradientAdapter());
    Hive.registerAdapter(SchoolBrandAdapter());
    Hive.registerAdapter(LearnYearAdapter());

    _userBox = await Hive.openBox<LocalIPortalProfile>(userBoxName);
  }

  @override
  Future<LocalIPortalProfile?> getUser() async {
    return _userBox.get(userKey);
  }

  @override
  Future saveUser(LocalIPortalProfile user) async {
    await _userBox.clear();
    await _userBox.put(userKey, user);
  }

  @override
  Future clearUser() async {
    await _userBox.clear();
  }
}
