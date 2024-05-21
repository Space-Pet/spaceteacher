part of 'setting_bloc.dart';

enum SettingStatus { init, loading, success, error }

class SettingState extends Equatable {
  final SettingStatus settingStatus;
  const SettingState({
    this.settingStatus = SettingStatus.init,
  });
  @override
  List<Object?> get props => [
        settingStatus,
      ];
  SettingState copyWith({
    SettingStatus? settingStatus,
  }) {
    return SettingState(
      settingStatus: settingStatus ?? this.settingStatus,
    );
  }
}
