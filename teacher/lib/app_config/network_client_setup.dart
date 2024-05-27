import 'package:core/core.dart';

class CustomDioClient extends AbstractDioClient {
  CustomDioClient({required super.domainSaver}) {
    init();
  }

  @override
  Future refreshTokenCall() async {}

  @override
  String get tokenFormat => "Bearer $accessToken";
}

class AuthRestClient extends RestApiClient {
  AuthRestClient(AuthorizeInterceptor authInterceptor,
      {required super.domainSaver})
      : super(
          dio: DioBuilder.createDio(
            interceptors: [
              authInterceptor,
            ],
          ),
        );
}

class PartnerTokenRestClient extends RestApiClient {
  PartnerTokenRestClient(PartnerTokenInterceptor partnerTokenInterceptor,
      {required super.domainSaver})
      : super(
          dio: DioBuilder.createDio(
            interceptors: [
              partnerTokenInterceptor,
            ],
          ),
        );
}
