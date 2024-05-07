part of 'send_otp_bloc.dart';

abstract class SendOtpEvent {}

class SendOtpRequested extends SendOtpEvent {}

class SendOtpResent extends SendOtpEvent {}

class SendOtpVerified extends SendOtpEvent {
  String otp;

  SendOtpVerified({
    required this.otp,
  });
}
