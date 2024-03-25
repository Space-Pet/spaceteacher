part of 'app_api_service.dart';

enum ErrorType {
  noInternet,
  httpException,
  timeout,

  /// occurred when refresh token with invalid token or user not found `or`
  /// status code is 401
  unauthorized,
  unknown,
  grapQLUnknown,
  grapQLInvalidToken,
  serverUnExpected,
}

class ErrorData {
  ErrorType? type;
  String? message;
  int? statusCode;
  String? errorCode;

  ErrorData({
    this.type,
    this.statusCode,
    this.message,
  });

  ErrorData.fromDio(dio_p.DioException error) {
    type = ErrorType.unknown;
    message = error.message;

    switch (error.type) {
      case dio_p.DioExceptionType.receiveTimeout:
      case dio_p.DioExceptionType.sendTimeout:
      case dio_p.DioExceptionType.connectionTimeout:
        type = ErrorType.timeout;
        break;
      case dio_p.DioExceptionType.badResponse:
        statusCode = error.response?.statusCode;
        errorCode = error.response?.data is Map<dynamic, dynamic>
            ? error.response?.data['code']?.toString()
            : errorCode;

        if (errorCode == ServerErrorCode.invalidToken ||
            errorCode == ServerErrorCode.userNotFound ||
            errorCode == ServerErrorCode.refreshToken ||
            statusCode == 401) {
          type = ErrorType.unauthorized;
          if (error.response?.data is Map<dynamic, dynamic>) {
            message = getErrorMessage(error.response?.data);
          }
        } else {
          type = ErrorType.httpException;
          if (error.response?.data is Map<dynamic, dynamic>) {
            message = getErrorMessage(error.response?.data);
          }
        }
        break;
      case dio_p.DioExceptionType.cancel:
        break;
      default:
        if (error.message?.contains('Unexpected character') ?? false) {
          type = ErrorType.serverUnExpected;
        } else {
          type = ErrorType.noInternet;
        }
        break;
    }
  }

  ErrorData.fromGraplQL({GraphQLException? error, Exception? exception}) {
    if (exception is RefreshTokenException ||
        (exception is LinkException &&
            exception.originalException is RefreshTokenException) ||
        error?.isAccessDenied == true ||
        error?.extensions?.code == ServerErrorCode.refreshToken) {
      type = ErrorType.grapQLInvalidToken;
    } else if (exception is SocketException || exception is NetworkException) {
      type = ErrorType.noInternet;
    } else if (exception is HttpException) {
      statusCode = 500;
      type = ErrorType.httpException;
    } else if (exception is ServerException) {
      type = ErrorType.httpException;
      message = error?.message;
    } else if (error?.isUnknowError == true || error?.isUnexpected == true) {
      //server exception like crash or something
      type = ErrorType.grapQLUnknown;
    } else {
      type = ErrorType.grapQLUnknown;
      message = error?.message;
      errorCode = error?.extensions?.code;
    }
  }

  String getErrorMessage(Map<String, dynamic> dataRes) {
    LogUtils.e('getErrorMessage $dataRes');
    try {
      if (dataRes.containsKey('message') && dataRes['message'] != null) {
        return dataRes['message'].toString();
      }
      if (dataRes.containsKey('error') && dataRes['error'] != null) {
        return dataRes['error'].toString();
      }
      if (dataRes.containsKey('errors') && dataRes['errors'] != null) {
        return dataRes['errors'].toString();
      }
    } catch (e) {
      /* ignore */
    }
    return dataRes.toString();
  }
}
