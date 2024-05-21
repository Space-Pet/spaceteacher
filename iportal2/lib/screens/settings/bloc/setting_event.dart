part of 'setting_bloc.dart';

@immutable
sealed class SettingEvent {}

class ChangePassword extends SettingEvent {
  final String currentPassword;
  final String password;
  final String passwordConfirmation;
  ChangePassword({
    required this.currentPassword,
    required this.password,
    required this.passwordConfirmation,
  });
}
