import 'dart:io';
import 'package:core/core.dart';

import '../token_manager_mixin.dart';

class AuthorizeInterceptor extends Interceptor with TokenManagementMixin {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await getToken();
    if (accessToken.isNotEmpty) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    }
    handler.next(options);
  }
}