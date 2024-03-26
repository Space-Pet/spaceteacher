import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

typedef MapString = Map<String, String>;

mixin TokenManagementMixin {
  String accessToken = '';
  String refreshToken = '';

  final _storage = const FlutterSecureStorage();
  final storageKey = '__NH_token_storage_key__';

  Future saveToken() async {
    final MapString tokenJson = {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
    await _storage.write(key: storageKey, value: jsonEncode(tokenJson));
  }

  Future<String> getAccessToken() async {
    String? token = await _storage.read(key: LocalStorageKey.token);

    accessToken = token ?? "";
    // refreshToken = (tokenJson['refreshToken'] ?? '') as String;

    return accessToken;
  }

  Future deleteToken() async {
    await _storage.delete(key: storageKey);

    accessToken = '';
    refreshToken = '';
  }
}
