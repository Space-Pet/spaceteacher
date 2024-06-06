part of 'setting_screen_bloc.dart';

enum SettingScreenStatus {
  initial,
  loading,
  success,
  failure,
  successChangePassword,
  failureChangePassword,
  turnOffNotiSuccess,
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
  bool get isTurnOffNotiSuccess =>
      this == SettingScreenStatus.turnOffNotiSuccess;
}

class SettingScreenState extends Equatable {
  const SettingScreenState({
    this.logoutStatus = SettingScreenStatus.initial,
    this.isDisableNoti = false,
    this.message,
  });

  final SettingScreenStatus logoutStatus;
  final String? message;
  final bool isDisableNoti;

  SettingScreenState copyWith({
    SettingScreenStatus? logoutStatus,
    String? message,
    bool? isDisableNoti,
  }) {
    return SettingScreenState(
      message: message ?? this.message,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      isDisableNoti: isDisableNoti ?? this.isDisableNoti,
    );
  }

  @override
  List<Object?> get props => [logoutStatus, message, isDisableNoti];
}
