part of 'setting_screen_bloc.dart';

enum SettingScreenStatus {
  initial,
  loading,
  success,
  failure,
  successChangePassword,
  failureChangePassword,
}

extension SettingScreenStatusX on SettingScreenStatus {
  bool get isInitial => this == SettingScreenStatus.initial;
  bool get isLoading => this == SettingScreenStatus.loading;
  bool get isSuccess => this == SettingScreenStatus.success;
  bool get isFailure => this == SettingScreenStatus.failure;
  bool get isSuccessChangePassword =>
      this == SettingScreenStatus.successChangePassword;
  bool get isFailureChangePassword =>
      this == SettingScreenStatus.failureChangePassword;
}

class SettingScreenState extends Equatable {
  const SettingScreenState({
    this.logoutStatus = SettingScreenStatus.initial,
    this.message,
  });

  final SettingScreenStatus logoutStatus;
  final String? message;

  SettingScreenState copyWith({
    SettingScreenStatus? logoutStatus,
    String? message,
  }) {
    return SettingScreenState(
      message: message ?? this.message,
      logoutStatus: logoutStatus ?? this.logoutStatus,
    );
  }

  @override
  List<Object?> get props => [
        logoutStatus,
        message,
      ];
}
