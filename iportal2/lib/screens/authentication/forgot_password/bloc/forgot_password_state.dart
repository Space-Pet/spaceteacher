part of 'forgot_password_bloc.dart';

enum ForgotPasswordStatus { init, loading, success, error }

class ForgotPasswordState {
  final ForgotPasswordStatus forgotPasswordStatus;
  final String? message;
  const ForgotPasswordState(
      {this.forgotPasswordStatus = ForgotPasswordStatus.init, this.message});
  List<Object?> get props => [message, forgotPasswordStatus];

  ForgotPasswordState copyWith(
      {String? message, ForgotPasswordStatus? forgotPasswordStatus}) {
    return ForgotPasswordState(
        message: message ?? this.message,
        forgotPasswordStatus:
            forgotPasswordStatus ?? this.forgotPasswordStatus);
  }
}
