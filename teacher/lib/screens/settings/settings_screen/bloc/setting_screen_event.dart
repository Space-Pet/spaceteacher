part of 'setting_screen_bloc.dart';

abstract class SettingScreenEvent {}

class SettingScreenLoggedOut extends SettingScreenEvent {}

class TurnOffNoti extends SettingScreenEvent {
  TurnOffNoti({
    required this.pushNotify,
  });

  final bool pushNotify;
}
