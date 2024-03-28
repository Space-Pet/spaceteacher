part of '../base.dart';

extension StateBaseErrorHandlerExt on StateBase {
  // void _onError(ErrorData error) {
  //   LogUtils.w(
  //       '''[$runtimeType] error ${error.type} message ${error.message}''');
  //   if (!mounted) {
  //     LogUtils.w('[$runtimeType] error when state disposed!');
  //     return;
  //   }
  //   hideLoading();
  //   switch (error.type) {
  //     case ErrorType.unauthorized:
  //     case ErrorType.grapQLInvalidToken:
  //       if (errorTypeShowing == error.type) {
  //         break;
  //       }
  //       errorTypeShowing = error.type;
  //       showLoginRequired(message: error.message);
  //       break;
  //     case ErrorType.httpException:
  //       if (errorTypeShowing == ErrorType.httpException) {
  //         break;
  //       }
  //       errorTypeShowing = ErrorType.httpException;
  //       if (error.statusCode != null &&
  //           error.statusCode! >= 500 &&
  //           error.statusCode! < 600) {
  //         showErrorDialog(trans.technicalIssues, error.errorCode);
  //       } else {
  //         onLogicError(trans.noConnection, error.errorCode);
  //       }
  //       break;
  //     case ErrorType.timeout:
  //       if (errorTypeShowing == ErrorType.timeout) {
  //         break;
  //       }
  //       errorTypeShowing = ErrorType.timeout;
  //       showErrorDialog(trans.connectionTimeout, error.errorCode);
  //       break;
  //     case ErrorType.noInternet:
  //       if (errorTypeShowing == ErrorType.noInternet) {
  //         break;
  //       }
  //       errorTypeShowing = ErrorType.noInternet;
  //       Connectivity().checkConnectivity().then((value) {
  //         if (value == ConnectivityResult.none) {
  //           showNoInternetDialog(error.errorCode!);
  //         } else {
  //           showErrorDialog(trans.technicalIssues, error.errorCode);
  //         }
  //       });
  //       break;
  //     case ErrorType.unknown:
  //       if (errorTypeShowing == ErrorType.unknown) {
  //         break;
  //       }
  //       errorTypeShowing = ErrorType.unknown;
  //       showErrorDialog(trans.unknownError, error.errorCode);
  //       break;
  //     case ErrorType.grapQLUnknown:
  //       if (errorTypeShowing == ErrorType.grapQLUnknown) {
  //         break;
  //       }
  //       errorTypeShowing = ErrorType.grapQLUnknown;
  //       onLogicError(error.message, error.errorCode);
  //       break;
  //     case ErrorType.serverUnExpected:
  //       if (errorTypeShowing == ErrorType.serverUnExpected) {
  //         break;
  //       }
  //       errorTypeShowing = ErrorType.serverUnExpected;
  //       showErrorDialog(trans.serverMaintenance, error.errorCode);
  //       break;
  //     default:
  //       break;
  //   }
  // }
}
