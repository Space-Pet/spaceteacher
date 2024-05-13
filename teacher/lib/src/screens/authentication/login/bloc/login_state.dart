part of 'login_bloc.dart';

enum LoginStatus { init, loading, readyToSubmit, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.showError = false,
    this.status = LoginStatus.init,
    this.cachedDomain = '',
  });

  final bool showError;
  final LoginStatus status;
  final String cachedDomain;

  @override
  List<Object> get props => [showError, status, cachedDomain];

  bool get isReadyToSubmit => status == LoginStatus.readyToSubmit;
  bool get isSuccess => status == LoginStatus.success;

  LoginState copyWith({
    bool? showError,
    LoginStatus? status,
    String? cachedDomain,
  }) {
    return LoginState(
      showError: showError ?? this.showError,
      status: status ?? this.status,
      cachedDomain: cachedDomain ?? this.cachedDomain,
    );
  }
}
