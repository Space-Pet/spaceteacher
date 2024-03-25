// ignore_for_file: depend_on_referenced_packages

import 'package:network_data_source/network_client/network_client.dart';

class CustomDioClient extends AbstractDioClient {
  CustomDioClient({required String baseUrl}) {
    init(baseUrl: baseUrl);
  }

  @override
  Future refreshTokenCall() async {}

  @override
  String get tokenFormat => 'Token $accessToken';
}
