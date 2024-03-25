import 'package:dio/dio.dart';

import '../../../../common/utils.dart';

class LoggerInterceptor extends Interceptor {
  final Function(DioError)? onRequestError;

  //For case response data is too large, dont need to show on log
  final bool Function(Response)? ignoreReponseDataLog;

  LoggerInterceptor({this.onRequestError, this.ignoreReponseDataLog});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LogUtils.i({
      'from': 'onRequest',
      'Time': DateTime.now().toString(),
      'baseUrl': options.baseUrl,
      'path': options.path,
      'headers': options.headers,
      'method': options.method,
      'requestData': options.data,
      'queryParameters': options.queryParameters,
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    LogUtils.i({
      'from': 'onResponse',
      'Time': DateTime.now().toString(),
      'statusCode': response.statusCode,
      'baseUrl': response.requestOptions.baseUrl,
      'path': response.requestOptions.path,
      'method': response.requestOptions.method,
      if (ignoreReponseDataLog == null ||
          ignoreReponseDataLog?.call(response) == false)
        'responseData': response.data,
    });

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    LogUtils.e({
      'from': 'onError',
      'Time': DateTime.now().toString(),
      'baseUrl': error.requestOptions.baseUrl,
      'header': error.requestOptions.headers,
      'path': error.requestOptions.path,
      'type': error.type.toString(),
      'message': error.message,
      'statusCode': error.response?.statusCode,
      'error': error.error.toString(),
      'responseData': error.response?.data
    }, error);
    onRequestError?.call(error);
    super.onError(error, handler);
  }
}
