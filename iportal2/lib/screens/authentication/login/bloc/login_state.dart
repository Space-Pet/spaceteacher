part of 'login_bloc.dart';

enum LoginStatus { init, loading, success, emptyLoginInfoError, failure }

class LoginState extends Equatable {
  const LoginState({
    required this.userName,
    required this.password,
    required this.isSaveLoginInfo,
    required this.isSuccess,
    required this.showError,
    this.status = LoginStatus.init,
    this.passwordVisible = false,
  });

  final String userName;
  final String password;
  final bool isSaveLoginInfo;
  final bool isSuccess;
  final bool showError;
  final LoginStatus status;
  final bool passwordVisible;

  @override
  List<Object> get props => [userName, password, isSaveLoginInfo, isSuccess,showError, status, passwordVisible];

  LoginState copyWith(
      {String? userName,
        String? password,
        bool? isSaveLoginInfo,
        bool? isSuccess,
        bool? showError,
        LoginStatus? status,
        bool? passwordVisible,
      }) {
    return LoginState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isSaveLoginInfo: isSaveLoginInfo ?? this.isSaveLoginInfo,
      isSuccess: isSuccess ?? this.isSuccess,
      showError: showError ?? this.showError,
      status: status ?? this.status,
      passwordVisible: passwordVisible ?? this.passwordVisible,
    );
  }
}
