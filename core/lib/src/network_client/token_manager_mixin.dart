import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mixin TokenManagementMixin {
  String accessToken = '';
  String refreshToken = '';

  final _storage = const FlutterSecureStorage();
  final storageKey = '__NH_token_storage_key__';

  Future saveToken() async {
    final tokenJson = {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
    await _storage.write(key: storageKey, value: jsonEncode(tokenJson));
  }

  Future getToken() async {
    final tokenJsonEncode = await _storage.read(key: storageKey);

    if (tokenJsonEncode != null) {
      final tokenJson = jsonDecode(tokenJsonEncode) as Map<String, dynamic>;

      accessToken = (tokenJson['accessToken'] ?? '') as String;
      refreshToken = (tokenJson['refreshToken'] ?? '') as String;
    }
  }

  Future deleteToken() async {
    await _storage.delete(key: storageKey);

    accessToken = '';
    refreshToken = '';
  }
}
