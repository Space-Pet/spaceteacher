import 'package:core/core.dart';
import 'package:local_data_source/user_local_storage/abstract_user_local_storage.dart';

class UserHiveStorage implements UserLocalStorage {
  late Box<LocalTeacher> _teacherBox;

  UserHiveStorage();

  static const teacherBoxName = '__NHG_Teacher_Box__';
  static const teaccherKey = '__NGH_Teacher_Key__';

  init() async {
    Hive.registerAdapter(LocalTeacherAdapter());
    Hive.registerAdapter(FeatureModelAdapter());
    Hive.registerAdapter(FeatureKeyAdapter());
    Hive.registerAdapter(FeatureCategoryAdapter());
    Hive.registerAdapter(FeatureGradientAdapter());
    Hive.registerAdapter(SchoolBrandAdapter());

    _teacherBox = await Hive.openBox<LocalTeacher>(teacherBoxName);
  }

  @override
  Future<LocalTeacher?> getUser() async {
    return _teacherBox.get(teaccherKey);
  }

  @override
  Future saveUser(LocalTeacher user) async {
    await _teacherBox.clear();
    await _teacherBox.put(teaccherKey, user);
  }

  @override
  Future clearUser() async {
    await _teacherBox.clear();
  }
}
