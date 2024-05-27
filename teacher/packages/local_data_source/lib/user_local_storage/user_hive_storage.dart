import 'package:core/core.dart';
import 'package:local_data_source/user_local_storage/abstract_user_local_storage.dart';

class UserHiveStorage implements UserLocalStorage {
  late Box<LocalTeacher> _teacherBox;
  late Box<List> _loggedUsersBox;

  UserHiveStorage();

  static const teacherBoxName = '__NHG_Teacher_Box__';
  static const teaccherKey = '__NGH_Teacher_Key__';

  static const loggedUsersBoxName = '__NHG_Logged_Users_Box__';
  static const loggedUsersKey = '__NGH_Logged_Users_Key__';

  init() async {
    Hive.registerAdapter(LocalTeacherAdapter());
    Hive.registerAdapter(LoggedUserAdapter());
    Hive.registerAdapter(LocalTrainingLevelAdapter());
    Hive.registerAdapter(FeatureModelAdapter());
    Hive.registerAdapter(FeatureKeyAdapter());
    Hive.registerAdapter(FeatureCategoryAdapter());
    Hive.registerAdapter(FeatureGradientAdapter());
    Hive.registerAdapter(SchoolBrandAdapter());

    _teacherBox = await Hive.openBox<LocalTeacher>(teacherBoxName);
    _loggedUsersBox = await Hive.openBox<List>(loggedUsersBoxName);
  }

  @override
  Future<LocalTeacher?> getUser() async {
    return _teacherBox.get(teaccherKey);
  }

  @override
  Future<List<LoggedUser>?> getLoggedUsers() async {
    final loggedUsers = _loggedUsersBox.get(loggedUsersKey);
    final result = loggedUsers?.map((e) => e as LoggedUser).toList();
    return result;
  }

  @override
  Future saveUser(LocalTeacher user) async {
    await _teacherBox.clear();
    await _teacherBox.put(teaccherKey, user);

    final loggedUsers = await getLoggedUsers() ?? [];
    final userMatch = loggedUsers.firstWhere(
      (element) => element.user_key == user.user_key,
      orElse: () => LoggedUser.empty(),
    );

    if (userMatch.user_key.isNotEmpty) {
      loggedUsers.removeWhere((element) => element.user_key == user.user_key);
      loggedUsers.add(
        LoggedUser(
            user_key: user.user_key,
            features: user.features,
            pinnedAlbumIdList: []),
      );
    } else {
      loggedUsers.add(
        LoggedUser(
          user_key: user.user_key,
          features: user.features,
          pinnedAlbumIdList: [],
        ),
      );
    }

    await _loggedUsersBox.clear();
    await _loggedUsersBox.put(loggedUsersKey, loggedUsers);
  }

  @override
  Future updatePinnedAlbum(
      List<int> pinnedAlbumIdList, String userKeyUpdate) async {
    final loggedUsers = await getLoggedUsers() ?? [];

    final userMatch = loggedUsers.firstWhere(
      (element) => element.user_key == userKeyUpdate,
      orElse: () => LoggedUser.empty(),
    );

    final updatedUser = userMatch.copyWith(
      pinnedAlbumIdList: pinnedAlbumIdList,
    );
    loggedUsers.remove(userMatch);
    loggedUsers.add(updatedUser);

    await _loggedUsersBox.put(loggedUsersKey, loggedUsers);
  }

  @override
  Future clearUser() async {
    await _teacherBox.clear();
  }
}
