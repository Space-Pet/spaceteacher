import 'dart:io';

import 'package:dio/dio.dart';
import 'package:network_data_source/network_client/network_client.dart';

abstract class AbstractDioClient with TokenManagementMixin {
  final dio = Dio();

  init({required String baseUrl}) {
    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) async {
        RequestOptions origin = error.requestOptions;

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

    dio.options.baseUrl = baseUrl;
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
  }

  void setHeader() {
    dio.options.headers["authorization"] = accessToken.isNotEmpty ? tokenFormat : accessToken;
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
  }) async {
    try {
      Response response = await dio.get(url, data: requestBody, queryParameters: queryParameters);
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
  }) async {
    try {
      Response response = await dio.post(
        url,
        data: requestBody,
        queryParameters: queryParameters,
      );

      return response.data as Json;
    } on DioError catch (e) {
      print(e.message.toString());
      rethrow;
    }
  }

  Future<Json> doHttpPut({
    required String url,
    Json? requestBody,
    Json? queryParameters,
  }) async {
    try {
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
  }) async {
    try {
      Response response = await dio.delete(
        url,
        data: requestBody,
        queryParameters: queryParameters,
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
