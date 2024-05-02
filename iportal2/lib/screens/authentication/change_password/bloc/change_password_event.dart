part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent {}

class ChangePassword extends ChangePasswordEvent {
  final String numberPhone;
  final String type;
  final String password;
  final String passwordConfirmation;
  ChangePassword(
      {required this.numberPhone,
      required this.password,
      required this.passwordConfirmation,
      required this.type});
  List<Object> get props => [numberPhone, type, password, passwordConfirmation];
}
