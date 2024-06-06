part of 'setting_bloc.dart';

enum SettingStatus { init, loading, success, error }

class SettingState extends Equatable {
  const SettingState({
    this.settingStatus = SettingStatus.init,
    this.errorMsg = '',
  });

  final SettingStatus settingStatus;
  final String errorMsg;

  @override
  List<Object?> get props => [settingStatus, errorMsg];

  SettingState copyWith({
    SettingStatus? settingStatus,
    String? errorMsg,
  }) {
    return SettingState(
      settingStatus: settingStatus ?? this.settingStatus,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
