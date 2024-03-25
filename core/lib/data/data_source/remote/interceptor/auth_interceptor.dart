import 'package:dio/dio.dart';

import '../../../../common/constants.dart';
import '../../../../common/utils.dart';

class AuthInterceptor extends Interceptor {
  final String? Function()? getToken;
  final Future<String?> Function(String, RequestOptions) refreshToken;
  final void Function()? onLogoutRequest;
  final String refreshTokenPath;
  final String logoutPath;

  AuthInterceptor({
    required this.refreshToken,
    this.getToken,
    this.onLogoutRequest,
    required this.refreshTokenPath,
    required this.logoutPath,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = getToken?.call();
    if (token?.isNotEmpty == true) {
      options.headers[HttpConstants.authorization] = token;
    }
    final headerToken = options.headers[HttpConstants.authorization];

    if (headerToken != null && options.path != refreshTokenPath) {
      if (JwtUtils.isAboutToExpire(token ?? '')) {
        refreshToken(token ?? '', options).then((newToken) {
          options.headers[HttpConstants.authorization] = newToken;
          _logoutRequestCallBack(options);
          super.onRequest(options, handler);
        }).catchError((e, stackTrace) {
          _logoutRequestCallBack(options);
          handler.reject(e);
        });
      } else {
        _logoutRequestCallBack(options);
        super.onRequest(options, handler);
      }
    } else {
      _logoutRequestCallBack(options);
      super.onRequest(options, handler);
    }
  }

  void _logoutRequestCallBack(RequestOptions options) {
    if (options.path == logoutPath) {
      onLogoutRequest?.call();
    }
  }
}
