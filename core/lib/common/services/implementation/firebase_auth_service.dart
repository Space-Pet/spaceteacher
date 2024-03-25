// class FirebaseAuthService extends AuthService {
//   late final _auth = FirebaseAuth.instance;
//   late final _autoVerifyStream = StreamController<VerifyOtp>.broadcast();

//   @override
//   bool get isSignedIn => _auth.currentUser != null;

//   int? _resendToken;
//   String? _token;
//   ConfirmationResult? _confirmationResult;

//   String? socialLoginEmail;

//   @override
//   Future<VerifyOtp?> requestOtp(
//      String phoneNumber, {
//      String? phoneCode
//  }) async {
//     await _auth.setSettings(
//       appVerificationDisabledForTesting: _isTestAccount(
//         phoneNumber,
//       ),
//     );
//     if (kIsWeb) {
//       return _requestOtpWeb(phoneNumber);
//     }
//     return _requestOtpMobile(
//       phoneNumber,
//       null,
//     );
//   }

//   @override
//   Future<VerifyOtp?> resendOtp(String phoneNumber, {String? phoneCode}) {
//     if (kIsWeb) {
//       return _requestOtpWeb(phoneNumber);
//     }
//     return _requestOtpMobile(phoneNumber, _resendToken, isLinkPhone: false);
//   }

//   @override
//   String? get token => _token;

//   @override
//   models.User? get user => null;

//   @override
//   Future<VerifyOtp?> verifyOtp(
//     String verificationId,
//     String code, {
//     bool isLinkPhone = false,
//   }) async {
//     if (kIsWeb) {
//       return _verifyCodeWeb(code);
//     }
//     return _verifyOTPMobile(verificationId, code);
//   }

//   Future<VerifyOtp?> _requestOtpMobile(
//     String phoneNumber,
//     int? resendToken, {
//     bool isLinkPhone = false,
//   }) {
//     final completer = Completer<VerifyOtp?>();
//     _auth.verifyPhoneNumber(
//         timeout: const Duration(seconds: 100),
//         phoneNumber: phoneNumber,
//         forceResendingToken: resendToken,
//         verificationCompleted: (PhoneAuthCredential credentials) async {
//           UserCredential? userCredential;
//           if (isLinkPhone) {
//             userCredential = await _auth.currentUser?.linkWithCredential(
//               credentials,
//             );
//           } else {
//             userCredential = await _auth.signInWithCredential(
//               credentials,
//             );
//           }
//           final token = await userCredential?.user?.getIdToken(true);
//           _token = token;
//           _autoVerifyStream.add(
//             VerifyOtp(
//               token,
//               null,
//               null,
//               VerifyStatus.success,
//               null,
//               null,
//             ),
//           );
//         },
//         verificationFailed: (FirebaseAuthException err) {
//           LogUtils.d('FIREBASE AUTH REQUEST OTP ERROR $err');
//           completer.complete(
//             VerifyOtp(
//               null,
//               err.message,
//               err.code,
//               VerifyStatus.failed,
//               null,
//               null,
//             ),
//           );
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           LogUtils.d('FIREBASE AUTH REQUEST OTP SENT $verificationId');
//           _resendToken = resendToken;
//           completer.complete(
//             VerifyOtp(
//               null,
//               null,
//               null,
//               VerifyStatus.sent,
//               resendToken,
//               verificationId,
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           // not handle
//           completer.complete(null);
//         });
//     return completer.future;
//   }

//   Future<VerifyOtp?> _verifyOTPMobile(
//     String verificationId,
//     String code,
//   ) async {
//     LogUtils.d('FIREBASE AUTH REQUEST VERIFY OTP $verificationId');
//     final credential = PhoneAuthteacher.credential(
//       verificationId: verificationId,
//       smsCode: code,
//     );
//     try {
//       final data = await _auth.signInWithCredential(credential);
//       final token = await data.user?.getIdToken(true);
//       _token = token;
//       return VerifyOtp(
//         token,
//         null,
//         null,
//         VerifyStatus.success,
//         null,
//         verificationId,
//       );
//     } on FirebaseAuthException catch (e) {
//       return VerifyOtp(
//         null,
//         e.code,
//         e.message,
//         VerifyStatus.failed,
//         null,
//         verificationId,
//       );
//     }
//   }

//   Future<VerifyOtp?> _requestOtpWeb(
//     String number,
//   ) async {
//     try {
//       _confirmationResult = await _auth.signInWithPhoneNumber(number);
//       return VerifyOtp(
//         null,
//         null,
//         null,
//         VerifyStatus.sent,
//         null,
//         null,
//       );
//     } on FirebaseAuthException catch (e) {
//       return VerifyOtp(
//         null,
//         null,
//         e.message,
//         VerifyStatus.failed,
//         null,
//         null,
//       );
//     }
//   }

//   Future<VerifyOtp?> _verifyCodeWeb(String code) async {
//     try {
//       final userCredential = await _confirmationResult?.confirm(
//         code,
//       );
//       final token = await userCredential?.user?.getIdToken(true);
//       _token = token;
//       return VerifyOtp(
//         token,
//         null,
//         null,
//         VerifyStatus.success,
//         null,
//         null,
//       );
//     } on FirebaseAuthException catch (e) {
//       return VerifyOtp(
//         null,
//         null,
//         e.message,
//         VerifyStatus.failed,
//         null,
//         null,
//       );
//     }
//   }

//   @override
//   Future<void> signOut() {
//     _token = null;
//     _resendToken = null;
//     return _auth.signOut();
//   }

//   @override
//   Future<void> init() async {
//     if (_auth.currentUser == null) {
//       await _auth.authStateChanges().first;
//     }
//     if (isSignedIn == true) {
//       _token = await _auth.currentUser?.getIdToken(true);
//     }
//   }

//   @override
//   Future<String?> refreshToken() async {
//     _token = await _auth.currentUser?.getIdToken(true);
//     return token;
//   }

//   bool _isTestAccount(String phone) {
//     final prodTestAccounts = ['976105222'];
//     for (final element in prodTestAccounts) {
//       if (phone.contains(element) == true) {
//         return true;
//       }
//     }
//     return false;
//   }

//   @override
//   Stream<VerifyOtp> get onAutoVerifySuccessful {
//     return _autoVerifyStream.stream;
//   }
// }
