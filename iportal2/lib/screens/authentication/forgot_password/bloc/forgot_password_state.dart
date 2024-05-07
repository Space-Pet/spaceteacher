// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_password_bloc.dart';

enum ForgotPasswordStatus { init, loading, success, error }

class ForgotPasswordState {
  final ForgotPasswordStatus forgotPasswordStatus;
  final String? message;
  final UserType userType;

  const ForgotPasswordState({
    this.forgotPasswordStatus = ForgotPasswordStatus.init,
    this.message,
    this.userType = UserType.parent,
  });

  List<Object?> get props => [
        message,
        forgotPasswordStatus,
        userType,
      ];

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? forgotPasswordStatus,
    String? message,
    UserType? userType,
  }) {
    return ForgotPasswordState(
      forgotPasswordStatus: forgotPasswordStatus ?? this.forgotPasswordStatus,
      message: message ?? this.message,
      userType: userType ?? this.userType,
    );
  }
}
