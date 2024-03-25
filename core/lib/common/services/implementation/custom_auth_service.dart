// import 'package:dartx/dartx.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:injectable/injectable.dart';

// import '../../../data/data_source/local/local_data_manager.dart';
// import '../../../data/data_source/remote/repository/auth_repository/auth_repository.dart';
// import '../../../data/models/authentication.dart';
// import '../../../data/models/verify_otp.dart';
// import '../../../di/di.dart';
// import '../../utils/phone_number_utils.dart';
// import '../auth_service.dart';

// @Singleton(as: AuthService)
// class CustomAuthService implements AuthService {
//   // Not yet implemented
//   // final _firebaseAuth = FirebaseAuth.instance;
//   final _authRepo = injector.get<AuthRepository>();
//   late final LocalDataManager _localDataManager =
//       injector.get<LocalDataManager>();

//   @override
//   bool get isSignedIn => _localDataManager.token.isNotNullOrEmpty;

//   @override
//   Stream<VerifyOtp>? get onAutoVerifySuccessful => null;

//   @override
//   Future<String?> refreshToken() async {
//     final result = await _authRepo.refreshToken(
//       _localDataManager.token ?? '',
//       _localDataManager.refreshToken ?? '',
//     );
//     _localDataManager
//       ..token = result?.accessToken
//       ..refreshToken = result?.refreshToken;

//     return result?.accessToken;
//   }

//   @override
//   Future<VerifyOtp?> requestOtp(PhoneNumber phoneNumber) async {
//     final result = await _authRepo.requestOtp(
//       phoneNumber.countryCode.toInt(),
//       phoneNumber.nationalNumber,
//     );
//     return VerifyOtp(
//       null,
//       null,
//       null,
//       VerifyStatus.sent,
//       null,
//       result?.id,
//     );
//   }

//   @override
//   Future<VerifyOtp?> resendOtp(PhoneNumber phoneNumber) async {
//     return requestOtp(phoneNumber);
//   }

//   @override
//   Future<void> signOut() async {
//     _localDataManager.token = null;
//     // Not yet implemented
//     // await _firebaseAuth.signOut();
//   }

//   @override
//   String? get token => _localDataManager.token;

//   @override
//   Future<VerifyOtp?> verifyOtp(
//     PhoneNumber phoneNumber,
//     String code,
//   ) async {
//     final result = await _authRepo.loginWithOtp(
//       code,
//       phoneNumber.countryCode.toInt(),
//       phoneNumber.nationalNumber,
//     );
//     _localDataManager
//       ..token = result?.accessToken
//       ..refreshToken = result?.refreshToken;

//     await loginFirebase();

//     return VerifyOtp(
//       result?.accessToken,
//       null,
//       null,
//       VerifyStatus.success,
//       null,
//       null,
//     );
//   }

//   @override
//   Future<LoginResult?> loginWithPassword(
//     PhoneNumber phoneNumber,
//     String password,
//   ) async {
//     final result = await _authRepo.loginWithPassword(
//       phoneNumber.countryCode.toInt(),
//       phoneNumber.nationalNumber,
//       password,
//     );
//     await loginFirebase();
//     _localDataManager
//       ..token = result?.accessToken
//       ..refreshToken = result?.refreshToken;
//     return result;
//   }

//   @override
//   Future<LoginResult?> registerTeacher() async {
//     throw UnimplementedError();
//   }

//   @override
//   Future<LoginResult?> updateTeacher() async {
//     throw UnimplementedError();
//   }

//   @override
//   Future<bool> loginFirebase() async {
//     // Not yet implemented
//     // if (_firebaseAuth.currentUser == null) {
//     //   await _firebaseAuth.signInAnonymously();
//     // }
//     return true;
//   }

//   @override
//   Future<bool?> changePassword(
//     String code,
//     int phoneCode,
//     String phoneNumber,
//     String password,
//   ) async {
//     final result =
//         await _authRepo.changePassword(code, phoneCode, phoneNumber, password);
//     return result;
//   }
// }
