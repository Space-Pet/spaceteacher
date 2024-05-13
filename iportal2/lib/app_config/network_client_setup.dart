// ignore_for_file: depend_on_referenced_packages

import 'package:network_data_source/network_client/dio_builder.dart';
import 'package:network_data_source/network_client/interceptors/authorize_interceptor.dart';
import 'package:network_data_source/network_client/interceptors/partner_token_interceptor.dart';
import 'package:network_data_source/network_client/network_client.dart';

class CustomDioClient extends AbstractDioClient {
  CustomDioClient({required String baseUrl, required super.domainSaver}) {
    init(baseUrl: baseUrl);
  }

  @override
  Future refreshTokenCall() async {}

  @override
  String get tokenFormat => "Bearer $accessToken";
}

class AuthRestClient extends RestApiClient {
  AuthRestClient(String baseUrl, AuthorizeInterceptor authInterceptor,
      {required super.domainSaver})
      : super(
          dio: DioBuilder.createDio(
            baseUrl: baseUrl,
            interceptors: [
              authInterceptor,
            ],
          ),
        );
}

class PartnerTokenRestClient extends RestApiClient {
  PartnerTokenRestClient(
      String baseUrl, PartnerTokenInterceptor partnerTokenInterceptor,
      {required super.domainSaver})
      : super(
          dio: DioBuilder.createDio(
            baseUrl: baseUrl,
            interceptors: [
              partnerTokenInterceptor,
            ],
          ),
        );
}
