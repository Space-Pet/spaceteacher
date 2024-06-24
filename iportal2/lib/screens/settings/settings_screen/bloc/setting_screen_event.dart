part of 'setting_screen_bloc.dart';

abstract class SettingScreenEvent {}

class SettingScreenLoggedOut extends SettingScreenEvent {}

class ChangePassword extends SettingScreenEvent {
  final String currentPassword;
  final String password;
  final String passwordConfirmation;
  ChangePassword({
    required this.currentPassword,
    required this.password,
    required this.passwordConfirmation,
  });
}

class TurnOffNoti extends SettingScreenEvent {
  TurnOffNoti({
    required this.pushNotify,
  });

  final int pushNotify;
}
