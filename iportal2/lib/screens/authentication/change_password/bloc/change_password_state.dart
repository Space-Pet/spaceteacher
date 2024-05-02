part of 'change_password_bloc.dart';

enum ChangePasswordStatus { init, loading, success, error }

class ChangePasswordState {
  final String? message;
  final ChangePasswordStatus changePasswordStatus;
  const ChangePasswordState(
      {this.changePasswordStatus = ChangePasswordStatus.init, this.message});
  List<Object?> get props => [message, changePasswordStatus];

  ChangePasswordState copyWith(
      {String? message, ChangePasswordStatus? changePasswordStatus}) {
    return ChangePasswordState(
        changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
        message: message ?? this.message);
  }
}
