part of 'setting_screen_bloc.dart';

enum SettingScreenStatus {
  initial,
  loading,
  success,
  failure,
}

extension SettingScreenStatusX on SettingScreenStatus {
  bool get isInitial => this == SettingScreenStatus.initial;
  bool get isLoading => this == SettingScreenStatus.loading;
  bool get isSuccess => this == SettingScreenStatus.success;
  bool get isFailure => this == SettingScreenStatus.failure;
}

class SettingScreenState extends Equatable {
  const SettingScreenState({
    this.logoutStatus = SettingScreenStatus.initial,
  });

  final SettingScreenStatus logoutStatus;

  SettingScreenState copyWith({SettingScreenStatus? logoutStatus}) {
    return SettingScreenState(
      logoutStatus: logoutStatus ?? this.logoutStatus,
    );
  }

  @override
  List<Object?> get props => [
        logoutStatus,
      ];
}
