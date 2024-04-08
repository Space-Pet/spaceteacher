
import 'package:core/core.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';

abstract class AuthRepository {
  Future<UserInfo?> login({String userName, String password});

  // Future<void> logout({String userName, String password});
}

class AuthRepositoryImp implements AuthRepository {
  @override
  Future<UserInfo?> login({String? userName, String? password}) async {
    try {
      final res = await ApiClient(ApiPath.login)
          .post({'user_key': userName, 'password': password, 'login_app': 0});

      if (isNullOrEmpty(res['data'])) return null;
      Log.d(res["data"]["info"]);
      final userInfo = UserInfo.fromJson(res["data"]["info"]);
      final settings = Injection.get<Settings>();
      await settings.saveAccessTokenSecure(res["data"]["access_token"]);

      // Log.prettyJson(
      //   res['data']['info'].toJson(),
      // );
      return userInfo;
    } catch (e) {
      Log.e('$e', name: "Login Error AuthRepository -> login()");
    }
    return UserInfo();
  }

  // @override
  // Future<void> logout({String userName, String password}) {
  //   // TODO: implement logout
  //   throw UnimplementedError();
  // }
}
