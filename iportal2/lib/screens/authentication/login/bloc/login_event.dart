part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

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
  final String deviceId;
  final String model;
  final String platform;
  final String tokenFirebase;
  const LoginQR(
      {required this.deviceId,
      required this.model,
      required this.platform,
      required this.qrCode,
      required this.tokenFirebase});
  @override
  List<Object> get props => [deviceId, model, platform, qrCode, tokenFirebase];
}
