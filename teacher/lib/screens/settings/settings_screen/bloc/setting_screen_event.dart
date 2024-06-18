part of 'setting_screen_bloc.dart';

abstract class SettingScreenEvent {}

class SettingScreenLoggedOut extends SettingScreenEvent {}

class TurnOnOffNoti extends SettingScreenEvent {
  TurnOnOffNoti({
    required this.pushNotify,
  });

  final int pushNotify;
}

class SettingFetchTeacherInfo extends SettingScreenEvent {
  SettingFetchTeacherInfo();
}
