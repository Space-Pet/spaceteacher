part of '../base.dart';

abstract class StateBase<T extends StatefulWidget> extends State<T>
    implements ApiServiceDelegate {
  ErrorType? errorTypeShowing;

  var _isLoadingShowing = false;

  dynamic get trans;

  String get languageCode => throw UnimplementedError();

  bool get isLoading => _isLoadingShowing;

  AppBlocBase? get bloc;

  LocalDataManager get localDataManager => injector.get();

  bool get willHandleError => true;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    LogUtils.d('[${T.toString()}] initState');
    if (willHandleError) {
      bloc?.errorHandler = onError;
    }
  }

  @override
  @mustCallSuper
  void didChangeDependencies() {
    refreshHeader();
    super.didChangeDependencies();
  }

  @override
  @mustCallSuper
  void dispose() {
    LogUtils.d('[${T.toString()}] dispose');
    super.dispose();
  }

  void showLoading({bool dismissOnTap = true}) {
    if (!_isLoadingShowing) {
      _isLoadingShowing = true;
      EasyLoading.show(
        status: trans.loading,
        indicator: const Loading(),
        dismissOnTap: dismissOnTap,
      );
    }
  }

  void hideLoading() {
    if (_isLoadingShowing) {
      _isLoadingShowing = false;
      EasyLoading.dismiss();
    }
  }

  @override
  void onError(ErrorData error) {
    hideLoading();
    _onError(error);
  }

  void showLoginNoticeDialog({
    required Function() onSuccess,
    Function()? onSkip,
  }) {}

  void backToAuth({
    Function()? onSuccess,
    Function()? onSkip,
  }) {}

  void showErrorDialog(String? message, String? errorCode,{Function()? onClose,}) {
    showNoticeErrorDialog(
      context: context,
      errorCode: errorCode,
      message: message?.isNotEmpty != true ? trans.technicalIssues : message!,
      onClose: () {
        onCloseErrorDialog();
        onClose?.call();
      },
      trans: trans,
    );
  }

  @mustCallSuper
  void onCloseErrorDialog() {
    errorTypeShowing = null;
  }

  void showLoginRequired({String? message, Function()? onConfirmed}) {
    showNoticeConfirmDialog(
      barrierDismissible: false,
      context: context,
      title: trans.inform,
      message: message ?? trans.sessionExpired,
      onConfirmed: () {
        onCloseErrorDialog();
        (onConfirmed ?? doLogout).call();
      },
      onCanceled: onCloseErrorDialog,
      trans: trans,
    );
  }

  void showNoInternetDialog(String errorCode) {
    showNoticeDialog(
      errorCode: errorCode,
      context: context,
      message: trans.noInternet,
      onClose: onCloseErrorDialog,
      trans: trans,
    );
  }

  void onLogicError(String? message, String? errorCode) {
    showErrorDialog(message, errorCode);
  }

  Widget baseLoading() {
    return const Loading();
  }

  Future<void> callCenter() async {
    final url =
        '''tel:${(localDataManager.appSettings?.hotline ?? AppConstant.hotline).replaceAll(' ', '')}''';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }
}
