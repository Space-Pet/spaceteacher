import 'package:aad_oauth/aad_oauth.dart';

import 'package:aad_oauth/model/config.dart';

import 'package:core/core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teacher/main.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';
import '../../src/services/network_services/api_client.dart';

abstract class AuthRepository {
  Future<UserInfo?> loginWith365();

  Future<void> logout();
}

class AuthRepositoryImp implements AuthRepository {
  @override
  Future<UserInfo?> loginWith365() async {
    UserInfo userInfo = UserInfo();
    final settings = Injection.get<Settings>();
    String email = '';
    try {
      final accessToken = await oauth.getAccessToken();

      if (accessToken != null && accessToken.isNotEmpty) {
        final decodeRes = JwtUtils.decode(accessToken);
        email = await decodeRes['unique_name'] ?? '';
      } else {
        final result = await oauth.login();
        await result.fold((l) async {
          Log.e(
            'Microsoft Authentication Failed!',
            name: 'auth_repositories ->  LoginWith365()',
          );
          Log.e('$l', name: 'auth_repositories ->  LoginWith365()');
        }, (r) async {
          final decodeRes = JwtUtils.decode(r.accessToken ?? '');
          email = await decodeRes['unique_name'] ?? '';
        });
      }

      if (email.isEmpty) {
        return null;
      }

      final res = await ApiClient(ApiPath.loginStaff)
          .post({'email': email, 'login_app': 0});

      if (isNullOrEmpty(res['data'])) return null;
      userInfo = UserInfo.fromJson(res["data"]["info"]);
      await settings.saveAccessTokenSecure(res["data"]["access_token"]);
      return userInfo;
    } catch (e) {
      Log.e('$e', name: "Login Error AuthRepository -> loginWith365()");
      // await oauth.logout();
      return null;
    }
  }

  AadOAuth get oauth {
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
    return AadOAuth(config);
  }

  @override
  Future<void> logout() async {
    // await oauth.logout();
    throw UnimplementedError();
  }
}
