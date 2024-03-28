import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();
  static const iphoneOptions =
      IOSOptions(accessibility: KeychainAccessibility.unlocked);
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static Future write(String key, String value) async {
    await _storage.write(
        key: key,
        value: value,
        aOptions: _getAndroidOptions(),
        iOptions: iphoneOptions);
  }

  static Future<String?> read(String key) async {
    return _storage.read(
        key: key, aOptions: _getAndroidOptions(), iOptions: iphoneOptions);
  }

  static Future<void> remove(String key) async {
    return _storage.delete(
        key: key, aOptions: _getAndroidOptions(), iOptions: iphoneOptions);
  }

  static Future<void> clearAllData() async {
    return _storage.deleteAll(
        aOptions: _getAndroidOptions(), iOptions: iphoneOptions);
  }
}
