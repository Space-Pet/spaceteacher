import 'dart:convert';

import 'package:core/core.dart';
import 'package:teacher/model/user_info.dart';

class Settings {
  Future<void> saveAccessTokenSecure(String accessToken) async =>
      await UserSecureStorage.write(
        LocalStorageKey.token,
        accessToken,
      );
  Future<void> saveRefreshTokenSecure(String refreshToken) async =>
      await UserSecureStorage.write(
        LocalStorageKey.refreshToken,
        refreshToken,
      );

  Future<void> saveUserModel(UserInfo userInfo) async =>
      await UserSecureStorage.write(
          LocalStorageKey.userLogin, json.encode(userInfo).toString());
  Future<void> clearUserInfoSecure() async =>
      await UserSecureStorage.remove(LocalStorageKey.userLogin);

  Future<void> clearAccessToken() async =>
      await UserSecureStorage.remove(LocalStorageKey.token);

  Future<void> clearAllDataSecure() async =>
      await UserSecureStorage.clearAllData();

  Future<String?> getAccessTokenSecure() async =>
      await UserSecureStorage.read(LocalStorageKey.token);
  Future<String?> getRefreshTokenSecure() async =>
      await UserSecureStorage.read(LocalStorageKey.refreshToken);

  Future<UserInfo?> getUserInfoSecure() async {
    final jsonData = await UserSecureStorage.read(LocalStorageKey.userLogin);
    return jsonData == null ? null : UserInfo.fromJson(json.decode(jsonData));
  }

  Future<String?> getAccessToken() async {
    final accessToken = await UserSecureStorage.read(LocalStorageKey.token);
    Log.d(accessToken);
    return accessToken;
  }

  Future<void> saveLanguage(String language) async {
    await UserSecureStorage.write(LocalStorageKey.language, language);
    print(await getLanguage());
  }

  Future<void> removeLanguage() async =>
      await UserSecureStorage.remove(LocalStorageKey.language);

  Future<String> getLanguage() async {
    final language =
        await UserSecureStorage.read(LocalStorageKey.language) ?? "en";
    return language;
  }

  Future<void> saveIsFirstTime(bool isFirstTime) async {
    await UserSecureStorage.write(
        LocalStorageKey.isFistTime, isFirstTime.toString());
  }

  Future<bool> getIsFirstTime() async {
    final isFirstTime =
        await UserSecureStorage.read(LocalStorageKey.isFistTime);
    return isFirstTime == null ? true : isFirstTime == "true";
  }
}
