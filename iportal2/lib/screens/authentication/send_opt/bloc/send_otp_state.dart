part of 'send_otp_bloc.dart';

enum SendOtpStatus { init, loading, success, error }

class SendOtpState extends Equatable {
  final SendOtpStatus status;

  final PhoneNumberVerificationInfo? verificationInfo;

  const SendOtpState({
    this.status = SendOtpStatus.init,
    this.verificationInfo,
  });

  @override
  List<Object?> get props => [
        status,
        verificationInfo,
      ];

  SendOtpState copyWith({
    SendOtpStatus? status,
    PhoneNumberVerificationInfo? verificationInfo,
  }) {
    return SendOtpState(
      status: status ?? this.status,
      verificationInfo: verificationInfo ?? this.verificationInfo,
    );
  }
}
