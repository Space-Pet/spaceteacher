import 'package:core/core.dart';
import 'package:local_data_source/local_data_source.dart';
import 'package:local_data_source/src/user_local_storage/user_local_storage.dart';

class UserHiveStorage implements UserLocalStorage {
  late Box<LocalIPortalProfile> _userBox;
  late Box<List> _featuresBox;

  UserHiveStorage();

  static const userBoxName = '__NHG_User_Box__';
  static const userKey = '__NGH_User_Key__';
  static const featuresBoxName = '__NHG_Features_Box__';
  static const featuresKey = '__NGH_Features_Key__';


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

    _userBox = await Hive.openBox<LocalIPortalProfile>(userBoxName);
    _featuresBox = await Hive.openBox<List>(featuresBoxName);
  }

  @override
  Future<LocalIPortalProfile?> getUser() async {
    return _userBox.get(userKey);
  }

  @override
  Future<List<LocalFeatures>?> getFeaturesLocal() async {
    final featuresLocal = _featuresBox.get(featuresKey);
    final result = featuresLocal?.map((e) => e as LocalFeatures).toList();
    return result;
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
