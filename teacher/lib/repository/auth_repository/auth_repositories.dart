import 'package:aad_oauth/aad_oauth.dart';

import 'package:aad_oauth/model/config.dart';

import 'package:core/core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teacher/main.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';

abstract class AuthRepository {
  Future<UserInfo?> login({String userName, String password});

  Future<UserInfo?> loginWith365();

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

  @override
  Future<UserInfo?> loginWith365() async {
    final String redirectUri = dotenv.env['REDIRECT_URI'] ?? '';
    final String clientId = dotenv.env['CLIENT_ID'] ?? '';
    final String tenant = dotenv.env['TENANT'] ?? '';
    final String clientScr = dotenv.env['CLIENT_SCR'] ?? '';

    final Config config = Config(
        tenant: tenant,
        clientId: clientId,
        scope: 'openid profile offline_access',
        redirectUri: redirectUri,
        responseType: 'code',
        clientSecret: clientScr,
        navigatorKey: navigatorKey);

    final AadOAuth oauth = AadOAuth(config);
    UserInfo userInfo = UserInfo();
    final settings = Injection.get<Settings>();
    String email = '';
    try {
      final result = await oauth.login();

      await result.fold((l) async {
        Log.e('Microsoft Authentication Failed!',
            name: 'auth_repositories ->  LoginWith365()');
      }, (r) async {
        final decodeRes = JwtUtils.decode(r.accessToken ?? '');
        email = await decodeRes['unique_name'] ?? '';
      });

      final res = await ApiClient(ApiPath.loginStaff)
          .post({'email': email, 'login_app': 0});

      if (isNullOrEmpty(res['data'])) return null;
      userInfo = UserInfo.fromJson(res["data"]["info"]);
      await settings.saveAccessTokenSecure(res["data"]["access_token"]);
      return userInfo;
    } catch (e) {
      Log.e('$e', name: "Login Error AuthRepository -> loginWith365()");
      await oauth.logout();
    }

    return UserInfo();
  }

  // @override
  // Future<void> logout({String userName, String password}) {
  //   // TODO: implement logout
  //   throw UnimplementedError();
  // }
}
