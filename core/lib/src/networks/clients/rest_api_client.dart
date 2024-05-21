import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../../presentation/screens/domain/domain_saver.dart';
import '../../storage/token_manager_mixin.dart';
import '../../utils/utils.dart';
import '../interceptor/exceptions.dart';

enum ApiMethod { get, post, put, delete, upload }

class ApiClientBase with TokenManagementMixin {
  final Dio dio = Dio();
  final String? prefix;
  final String? suffix;
  bool isRefreshingToken = false;

  final DomainSaver domainSaver;

  ApiClientBase({
    Map<String, dynamic>? headers,
    this.prefix,
    this.suffix,
    required this.domainSaver,
  }) {
    dio.httpClientAdapter = IOHttpClientAdapter();
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);
    dio.options.contentType = Headers.jsonContentType;
    dio.options.receiveDataWhenStatusError = true;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await getAccessToken();
          if (token.isNotEmpty) {
            dio.options.headers['Authorization'] = 'Bearer $token';
          }

          final log = StringBuffer()
            ..write('--> METHOD ${options.method.toUpperCase()}\n');

          if (isNullOrEmpty(options.baseUrl)) {
            final domain = await domainSaver.getDomain();
            if (domain.isNotEmpty) {
              var tempDomain = domain;
              if (prefix != null) {
                tempDomain = '$prefix$tempDomain';
              }
              if (suffix != null) {
                tempDomain = '$tempDomain$suffix';
              }
              options.baseUrl = 'https://$tempDomain';
            }
          }

          log
            ..write('--> DOMAIN: ${options.baseUrl}\n')
            ..write('--> PATH: ${options.path}\n')
            ..write('--> HEADERS:\n');

          options.headers.forEach((k, v) => log.write('$k: $v; '));
          if (!isNullOrEmpty(options.queryParameters)) {
            log.write('\nPARAMS: ');
            options.queryParameters.forEach((k, v) => log.write('$k: $v; '));
          }
          if (!isNullOrEmpty(options.data)) {
            try {
              final responseDataJson = json.encode(options.data);
              final logList = splitByLength(responseDataJson, 900);
              if (!isNullOrEmpty(logList)) {
                log.write('\nBODY:');
                if (responseDataJson.length > 3000) {
                  log.write('\n$responseDataJson');
                } else {
                  final logList = splitByLength(responseDataJson, 900);
                  if (!isNullOrEmpty(logList)) {
                    for (final it in logList) {
                      log.write('\n$it');
                    }
                  }
                }
              }
            } catch (e) {
              log.write('\nBODY: Cannot convert to JSON');
            }
          }
          log.write('\n--> END');
          Log.d(log.toString());

          handler.next(options);
        },
        onResponse: (res, handler) {
          final log = StringBuffer();
          final statusCode = res.statusCode;
          final url = !isNullOrEmpty(res.requestOptions.path)
              ? '${res.requestOptions.baseUrl}${res.requestOptions.path}'
              : 'URL';

          log
            ..write('<-- $statusCode $url')
            ..write('\nHEADERS: ');
          res.headers.forEach((k, v) => log.write('$k: $v; '));
          if (!isNullOrEmpty(res.data)) {
            try {
              final responseDataJson = json.encode(res.data);
              log.write('\nRESPONSE:');
              if (responseDataJson.length > 3000) {
                log.write('\n$responseDataJson');
              } else {
                final logList = splitByLength(responseDataJson, 900);
                if (!isNullOrEmpty(logList)) {
                  for (final it in logList) {
                    log.write('\n$it');
                  }
                }
              }
            } catch (e) {
              log.write('\nRESPONSE: Cannot convert to JSON');
            }
          }
          log.write('\n<-- END HTTP');
          Log.d(log.toString());
          handler.next(res);
        },
        onError: (err, handler) {
          switch (err.type) {
            case DioExceptionType.connectionTimeout:
            case DioExceptionType.sendTimeout:
            case DioExceptionType.receiveTimeout:
              throw DeadlineExceededException(err.requestOptions);
            case DioExceptionType.badResponse:
              switch (err.response?.statusCode) {
                case 400:
                  Log.e('${BadRequestException(err.requestOptions)}',
                      name: '$err');
                  break;
                case 401:
                  Log.e('${UnauthorizedException(err.requestOptions)}',
                      name: '$err');
                  break;
                case 403:
                  Log.e('${UnauthorizedException(err.requestOptions)}',
                      name: '$err');
                  break;
                case 404:
                  Log.e('${NotFoundException(err.requestOptions)}',
                      name: '$err');
                  break;
                case 409:
                  Log.e('${ConflictException(err.requestOptions)}',
                      name: '$err');
                  break;
                case 500:
                  Log.e('${InternalServerErrorException(err.requestOptions)}',
                      name: '$err');
                  break;
              }
              break;
            case DioExceptionType.cancel:
              break;
            case DioExceptionType.unknown:
              Log.e('${NoInternetConnectionException(err.requestOptions)}',
                  name: '$err');
              throw NoInternetConnectionException(err.requestOptions);
            case DioExceptionType.badCertificate:
              // [TODO]: Handle this case.
              break;
            case DioExceptionType.connectionError:
              // [TODO]: Handle this case.
              break;
          }
          Log.e(
            '[${err.response?.statusCode}] - ${err.response?.headers ?? ''}\n${err.error}',
            name: err.requestOptions.path,
          );
          handler.next(err);
        },
      ),
    );

    if (!isNullOrEmpty(headers)) {
      dio.options.headers.addAll(headers!);
    }
  }

  Future<dynamic> get(String path, [Map<String, dynamic>? params]) =>
      _callApi(ApiMethod.get, body: params ?? {}, path: path);

  Future<dynamic> post(String path, dynamic body,
          [Map<String, dynamic>? params]) =>
      _callApi(ApiMethod.post, body: body, params: params, path: path);

  Future<dynamic> put(String path, dynamic body,
          [Map<String, dynamic>? params]) =>
      _callApi(ApiMethod.put, body: body, params: params, path: path);

  Future<dynamic> delete(String path, dynamic body,
          [Map<String, dynamic>? params]) =>
      _callApi(ApiMethod.delete, body: body, params: params, path: path);

  ApiMethod getMethod(String methodString) {
    switch (methodString) {
      case 'GET':
        return ApiMethod.get;
      case 'POST':
        return ApiMethod.post;
      case 'UPLOAD':
        return ApiMethod.upload;
      case 'DELETE':
        return ApiMethod.delete;
      case 'PUT':
        return ApiMethod.put;
    }
    return ApiMethod.get;
  }

  Future<dynamic> _callApi(
    ApiMethod method, {
    required String path,
    dynamic body,
    Map<String, dynamic>? params,
  }) async {
    Response? response;
    var encodedUrl = path;
    if (method == ApiMethod.get &&
        !isNullOrEmpty(body) &&
        body is Map<String, dynamic>) {
      encodedUrl = getUrlWithQuery(path, body);
    }
    try {
      switch (method) {
        case ApiMethod.get:
          response = await dio.get(encodedUrl);

          break;
        case ApiMethod.post:
          response = await dio.post(
            getUrlWithQuery(encodedUrl, params ?? {}),
            data: body,
          );

          break;
        case ApiMethod.put:
          response = await dio.put(getUrlWithQuery(encodedUrl, params ?? {}),
              data: body);

          break;
        case ApiMethod.delete:
          response = await dio.delete(getUrlWithQuery(encodedUrl, params ?? {}),
              data: body);

          break;
        case ApiMethod.upload:
          response =
              await dio.post(encodedUrl, data: body, queryParameters: params);

          break;
      }
    } catch (e) {
      Log.e(
        '$path\n$e',
        name: 'ApiClient -> callApi()',
      );
    }

    return response?.data;
  }
}
