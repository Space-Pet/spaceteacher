part of 'login_bloc.dart';

enum LoginStatus { init, loading, success, emptyLoginInfoError, failure }

class LoginState extends Equatable {
  const LoginState({
    required this.userName,
    required this.password,
    required this.isSaveLoginInfo,
    required this.isSuccess,
    required this.showError,
    required this.domain,
    required this.deviceInfo,
    this.status = LoginStatus.init,
    this.passwordVisible = false,
    this.failureMessage,
  });

  final String userName;
  final String password;
  final bool isSaveLoginInfo;
  final bool isSuccess;
  final bool showError;
  final LoginStatus status;
  final bool passwordVisible;
  final String domain;
  final DeviceInfo deviceInfo;
  final String? failureMessage;

  @override
  List<Object?> get props => [
        userName,
        password,
        isSaveLoginInfo,
        isSuccess,
        showError,
        status,
        passwordVisible,
        domain,
        deviceInfo,
        failureMessage,
      ];

  LoginState copyWith({
    String? userName,
    String? password,
    bool? isSaveLoginInfo,
    bool? isSuccess,
    bool? showError,
    LoginStatus? status,
    bool? passwordVisible,
    String? domain,
    DeviceInfo? deviceInfo,
    String? failureMessage,
  }) {
    return LoginState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isSaveLoginInfo: isSaveLoginInfo ?? this.isSaveLoginInfo,
      isSuccess: isSuccess ?? this.isSuccess,
      showError: showError ?? this.showError,
      status: status ?? this.status,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      domain: domain ?? this.domain,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}

class DeviceInfo {
  String deviceId;
  String model;
  String platform;
  String tokenFirebase;

  DeviceInfo({
    required this.deviceId,
    required this.model,
    required this.platform,
    required this.tokenFirebase,
  });

  factory DeviceInfo.empty() {
    return DeviceInfo(
      deviceId: '',
      model: '',
      platform: '',
      tokenFirebase: '',
    );
  }
}
