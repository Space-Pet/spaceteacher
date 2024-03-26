import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();
  static const iphoneOptions =
      IOSOptions(accessibility: KeychainAccessibility.first_unlock);
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static Future write(String key, value) async {
    await _storage.write(
        key: key,
        value: value,
        aOptions: _getAndroidOptions(),
        iOptions: iphoneOptions);
  }

  static Future<String?> read(key) async {
    return await _storage.read(
        key: key, aOptions: _getAndroidOptions(), iOptions: iphoneOptions);
  }

  static Future<void> remove(String key) async {
    return await _storage.delete(
        key: key, aOptions: _getAndroidOptions(), iOptions: iphoneOptions);
  }

  static Future<void> clearAllData() async {
    return await _storage.deleteAll(
        aOptions: _getAndroidOptions(), iOptions: iphoneOptions);
  }
}
