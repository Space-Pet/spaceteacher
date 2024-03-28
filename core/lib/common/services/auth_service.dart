
abstract class AuthService {
  bool get isSignedIn;

  String? get token;

  // Future<VerifyOtp?> requestOtp(
  //   PhoneNumber phoneNumber,
  // );

  // Future<VerifyOtp?> resendOtp(
  //   PhoneNumber phoneNumber,
  // );

  // Future<VerifyOtp?> verifyOtp(
  //   PhoneNumber phoneNumber,
  //   String code,
  // );

  Future<bool?> changePassword(
    String code,
    int phoneCode,
    String phoneNumber,
    String password,
  );

  Future<String?> refreshToken();

  Future<void> signOut();

  // Stream<VerifyOtp>? get onAutoVerifySuccessful;

  // Future<LoginResult?> loginWithPassword(
  //   PhoneNumber phoneNumber,
  //   String password,
  // );

  // Future<LoginResult?> registerTeacher();

  // Future<LoginResult?> updateTeacher();

  Future<bool> loginFirebase();
}
