enum VerifyStatus { success, sent, failed }

class VerifyOtp {
  final String? token;
  final String? code;
  final String? message;
  final VerifyStatus status;
  final int? resendToken;
  final String? verificationId;

  VerifyOtp(
    this.token,
    this.code,
    this.message,
    this.status,
    this.resendToken,
    this.verificationId,
  );

  Map<String, dynamic> asMap() {
    return {
      'token': token,
      'message': message,
      'status': status,
      'resendToken': resendToken,
      'verificationId': verificationId,
    };
  }
}
