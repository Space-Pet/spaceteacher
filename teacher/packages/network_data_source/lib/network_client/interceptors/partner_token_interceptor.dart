import 'package:core/core.dart';

import '../token_manager_mixin.dart';

class PartnerTokenInterceptor extends Interceptor with TokenManagementMixin {
  static String partnerHeader = 'Parter-Token';

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const faketoken =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJPbmxpbmUgSldUIEJ1aWxkZXIiLCJpYXQiOjE2NTczMzE2ODgsImV4cCI6MTY4ODg2NzY4OCwiYXVkIjoid3d3LmV4YW1wbGUuY29tIiwic3ViIjoianJvY2tldEBleGFtcGxlLmNvbSIsIkdpdmVuTmFtZSI6IkpvaG5ueSIsIlN1cm5hbWUiOiJSb2NrZXQiLCJFbWFpbCI6Impyb2NrZXRAZXhhbXBsZS5jb20iLCJSb2xlIjpbIk1hbmFnZXIiLCJQcm9qZWN0IEFkbWluaXN0cmF0b3IiXX0.3PXXeua7B4UfGhvH4s8QWKCzf5w0M_uGUODs7-wXj_g';

    options.headers[partnerHeader] = faketoken;

    handler.next(options);
  }
}
