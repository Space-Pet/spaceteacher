part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class InitDomain extends LoginEvent {
  const InitDomain();

  @override
  List<Object> get props => [];
}

class InitDeviceInfo extends LoginEvent {
  const InitDeviceInfo();

  @override
  List<Object> get props => [];
}

class PasswordVisibility extends LoginEvent {
  const PasswordVisibility();

  @override
  List<Object> get props => [];
}

class RemenberPassword extends LoginEvent {
  const RemenberPassword();
  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.userName);

  final String userName;

  @override
  List<Object> get props => [userName];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {}

class LoginQR extends LoginEvent {
  final String qrCode;

  const LoginQR({required this.qrCode});
  @override
  List<Object> get props => [qrCode];
}
