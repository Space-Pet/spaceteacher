class PhoneNumberVerificationInfo {
  final int? forceResendingToken;
  final String verificationId;

  PhoneNumberVerificationInfo({
    required this.forceResendingToken,
    required this.verificationId,
  });
}
