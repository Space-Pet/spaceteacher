// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:core/core.dart';
import 'package:core/presentation/screens/domain/domain_saver.dart';
import 'package:network_data_source/network_client/network_client.dart';

abstract class AbstractDioClient with TokenManagementMixin {
  AbstractDioClient({required this.domainSaver});
  final dio = Dio();

  final DomainSaver domainSaver;

  init() {
    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) async {
        // if (unauthenCall(error.response?.statusCode)) {
        //   await refreshTokenCall();
        //   // handler.resolve(await dio.request(origin.path, options: origin));
        //   var response = await dio.request(
        //     origin.path,
        //     data: origin.data,
        //     queryParameters: origin.queryParameters,
        //     options: Options(
        //       method: origin.method,
        //       headers: origin.headers,
        //     ),
        //   );
        //   return handler.resolve(response);
        // }
        handler.next(error);
      },
    ));
  }

  Future<void> ensureInitialized({String? method, String? path}) async {
    final baseUrl = await domainSaver.getDomain();
    final dioBaseUrl = dio.options.baseUrl;
    if (baseUrl.isNotEmpty && dioBaseUrl != 'https://$baseUrl') {
      dio.options.baseUrl = 'https://$baseUrl';
    }
  }

  static bool unauthenCall(int? statusCode) {
    return statusCode == 403 || statusCode == 401;
  }

  updateAccessToken(String accessToken) {
    this.accessToken = accessToken;
    setHeader();
    saveToken();
  }

  clearToken() async {
    await deleteToken();
    setHeader();
    dio.options.baseUrl = '';
  }

  void setHeader() {
    dio.options.headers["authorization"] =
        accessToken.isNotEmpty ? tokenFormat : accessToken;

    const parnerToken =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJPbmxpbmUgSldUIEJ1aWxkZXIiLCJpYXQiOjE2NTczMzE2ODgsImV4cCI6MTY4ODg2NzY4OCwiYXVkIjoid3d3LmV4YW1wbGUuY29tIiwic3ViIjoianJvY2tldEBleGFtcGxlLmNvbSIsIkdpdmVuTmFtZSI6IkpvaG5ueSIsIlN1cm5hbWUiOiJSb2NrZXQiLCJFbWFpbCI6Impyb2NrZXRAZXhhbXBsZS5jb20iLCJSb2xlIjpbIk1hbmFnZXIiLCJQcm9qZWN0IEFkbWluaXN0cmF0b3IiXX0.3PXXeua7B4UfGhvH4s8QWKCzf5w0M_uGUODs7-wXj_g';

    dio.options.headers["Parter-Token"] = parnerToken;

    // accessToken.isNotEmpty ? tokenFormat : accessToken;
  }

  String get tokenFormat => accessToken;

  Future refreshTokenCall();
  Future<String?> getAccessToken() async {
    await getToken();
    return accessToken.isNotEmpty ? accessToken : null;
  }

  Future<Json> doHttpGet(
    String url, {
    Json? requestBody,
    Json? queryParameters,
    Json? headers,
  }) async {
    try {
      await ensureInitialized(method: 'GET', path: url);
      Response response = await dio.get(
        url,
        data: requestBody,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      final data = response.data;
      return data as Json;
    } on DioError {
      throw Exception();
    }
  }

  Future<Json> doHttpPost({
    required String url,
    Json? requestBody,
    Json? queryParameters,
    Json? headers,
  }) async {
    try {
      await ensureInitialized(method: 'POST', path: url);
      Response response = await dio.post(
        url,
        data: requestBody,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );

      return response.data as Json;
    } on DioError {
      rethrow;
    }
  }

  Future<Json> doHttpPut({
    required String url,
    Json? requestBody,
    Json? queryParameters,
  }) async {
    try {
      await ensureInitialized(method: 'PUT', path: url);
      Response response = await dio.put(
        url,
        data: requestBody,
        queryParameters: queryParameters,
      );

      return response.data as Json;
    } on DioError {
      throw Exception();
    }
  }

  Future<Json> doPut({
    required String url,
    Json? queryParameters,
    List<Map<String, Object>>? data,
  }) async {
    try {
      await ensureInitialized(method: 'PUT', path: url);
      Response response = await dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
      );

      return response.data as Json;
    } on DioError {
      throw Exception();
    }
  }

  Future<Json> doPost({
    required String url,
    Json? queryParameters,
    List<Map<String, Object>>? data,
  }) async {
    try {
      await ensureInitialized(method: 'POST', path: url);
      Response response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
      );

      return response.data as Json;
    } on DioError {
      throw Exception();
    }
  }

  Future<Json> doPostCreate({
    required String url,
    Json? queryParameters,
    required Map<String, Object?> data,
  }) async {
    try {
      await ensureInitialized(method: 'POST', path: url);
      Response response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
      );

      return response.data as Json;
    } on DioError {
      throw Exception();
    }
  }

  Future<Json> doHttpDelete({
    required String url,
    Json? requestBody,
    Json? queryParameters,
    Json? headers,
  }) async {
    try {
      await ensureInitialized(method: 'DELETE', path: url);
      Response response = await dio.delete(
        url,
        data: requestBody,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );

      return response.data as Json;
    } on DioError {
      throw Exception();
    }
  }

  Future<Json> uploadFile({
    required String url,
    required String filePath,
  }) async {
    try {
      await ensureInitialized(method: 'POST', path: url);
      final fileName = filePath.split('/').last;

      final formData = FormData.fromMap({
        'File': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        ),
      });
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'multipart/form-data',
            HttpHeaders.authorizationHeader: tokenFormat,
          },
        ),
      );

      return response.data as Json;
    } on DioError {
      throw Exception();
    }
  }

  Future<Json> doHttpPostFile(
      {required String url,
      String? order,
      required String comment,
      required String fileName,
      required File attachment,
      String? creationUser,
      String? requestmodel,
      String? declaration,
      String? stocktaking}) async {
    try {
      await ensureInitialized(method: 'POST', path: url);
      final formData = FormData.fromMap({
        "user": creationUser,
        "order": order,
        "comment": comment,
        "filename": fileName,
        "attachment": await MultipartFile.fromFile(
          attachment.path,
          filename: fileName,
        ),
        "requestmodel": requestmodel,
        "declaration": declaration,
        "stocktaking": stocktaking
      });

      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'multipart/form-data',
            HttpHeaders.authorizationHeader: tokenFormat,
          },
        ),
      );

      return response.data as Json;
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }
}

class RestApiClient {
  RestApiClient({
    required this.dio,
    required this.domainSaver,
  });

  final Dio dio;
  final DomainSaver domainSaver;

  Future<void> ensureInitialized({String? method, String? path}) async {
    final baseUrl = await domainSaver.getDomain();
    final dioBaseUrl = dio.options.baseUrl;
    print(
        'RestApiClient - ensureInitialized baseUrl: $baseUrl - method: $method - path: $path');
    if (baseUrl.isNotEmpty && dioBaseUrl != 'https://$baseUrl') {
      dio.options.baseUrl = 'https://$baseUrl';
      print(dio.options.baseUrl);
    }
  }

  void clearDomain() {
    dio.options.baseUrl = '';
  }

  Future<Json> doHttpGet(
    String url, {
    Json? requestBody,
    Json? queryParameters,
    Json? headers,
  }) async {
    try {
      await ensureInitialized(method: 'GET', path: url);
      Response response = await dio.get(
        url,
        data: requestBody,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      final data = response.data;
      return data as Json;
    } on DioError {
      throw Exception();
    }
  }

  Future<Json> doHttpPost({
    required String url,
    Json? requestBody,
    Json? queryParameters,
    Json? headers,
    List<Map<String, dynamic>>? data,
  }) async {
    await ensureInitialized(method: 'POST', path: url);
    Response response = await dio.post(
      url,
      data: requestBody ?? data,
      queryParameters: queryParameters,
      options: headers != null ? Options(headers: headers) : null,
    );

    return response.data as Json;
  }

  Future<Json> doHttpPut({
    required String url,
    Json? requestBody,
    Json? queryParameters,
  }) async {
    await ensureInitialized(method: 'PUT', path: url);
    Response response = await dio.put(
      url,
      data: requestBody,
      queryParameters: queryParameters,
    );

    return response.data as Json;
  }

  Future<Json> doHttpDelete({
    required String url,
    Json? requestBody,
    Json? queryParameters,
  }) async {
    await ensureInitialized(method: 'DELETE', path: url);
    Response response = await dio.delete(
      url,
      data: requestBody,
      queryParameters: queryParameters,
    );

    return response.data as Json;
  }

  Future<Json> uploadFile({
    required String url,
    required FormData formData,
  }) async {
    await ensureInitialized(method: 'POST', path: url);
    Response response = await dio.post(
      url,
      data: formData,
    );

    return response.data as Json;
  }
}
