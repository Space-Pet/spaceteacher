import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

part 'send_otp_event.dart';
part 'send_otp_state.dart';

class SendOtpBloc extends Bloc<SendOtpEvent, SendOtpState> {
  SendOtpBloc({
    required this.phoneNumber,
    required this.authRepository,
  }) : super(const SendOtpState()) {
    on<SendOtpRequested>(_onRequestOtp);
    on<SendOtpVerified>(_onVerifyOtp);
    on<SendOtpResent>(_onResendOtp);
  }

  final String phoneNumber;
  final AuthRepository authRepository;

  _onRequestOtp(
    SendOtpRequested event,
    Emitter<SendOtpState> emit,
  ) async {
    final verificationInfo = await authRepository.sendOTP(phoneNumber);

    emit(state.copyWith(
      verificationInfo: verificationInfo,
    ));
  }

  _onResendOtp(
    SendOtpResent event,
    Emitter<SendOtpState> emit,
  ) async {
    if (state.verificationInfo == null) {
      return;
    }

    final verificationInfo = await authRepository.resendOTP(
      phoneNumber,
      state.verificationInfo!.forceResendingToken,
    );

    emit(state.copyWith(
      verificationInfo: verificationInfo,
    ));
  }

  _onVerifyOtp(
    SendOtpVerified event,
    Emitter<SendOtpState> emit,
  ) async {
    if (state.verificationInfo == null) {
      return;
    }
    try {
      emit(state.copyWith(status: SendOtpStatus.loading));

      await authRepository.verifyOTP(
        state.verificationInfo!.verificationId,
        event.otp,
      );

      emit(state.copyWith(status: SendOtpStatus.success));
    } catch (_) {
      emit(state.copyWith(status: SendOtpStatus.error));
      rethrow;
    }
  }
}
