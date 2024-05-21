import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_data_source/local_data_source.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/src/models/phone_number_verification_info.dart';

class AuthRepository {
  AuthRepository({
    required AuthApi authApi,
    required AbstractAuthLocalStorage authLocalStorage,
  })  : _authApi = authApi,
        _authLocalStorage = authLocalStorage;
  final AuthApi _authApi;
  final AbstractAuthLocalStorage _authLocalStorage;

  String userId = '';
  Future<LocalLoginInfo?> getLocalLognInfo() =>
      _authLocalStorage.getLoginInfo();
  Future<String> getPassword(
      {required String numberPhone,
      required String type,
      required String password,
      required String passwordConfirmation}) async {
    final data = await _authApi.getPassword(
        numberPhone: numberPhone,
        type: type,
        password: password,
        passwordConfirmation: passwordConfirmation);
    return data;
  }

  Future<String> checkNumberPhone({
    required String numberPhone,
    required String type,
  }) async {
    final data =
        await _authApi.checkNumberPhone(numberPhone: numberPhone, type: type);
    return data;
  }

  Future<ProfileInfo> login({
    required String userName,
    required String password,
    required String deviceId,
    required String model,
    required String platform,
    required String tokenFirebase,
  }) async {
    try {
      final loginInfo = await _authApi.login(
        email: userName,
        password: password,
        deviceId: deviceId,
        model: model,
        platform: platform,
        tokenFirebase: tokenFirebase,
      );

      await _authLocalStorage.clearLoginInfo();
      await _authLocalStorage.saveLoginInfo(
        email: userName,
        password: password,
      );
      return loginInfo;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfileInfo> loginQR({
    required String qrCode,
    required String deviceId,
    required String model,
    required String platform,
    required String tokenFirebase,
  }) async {
    final loginInfo = await _authApi.loginQR(
        qrCode: qrCode,
        deviceId: deviceId,
        model: model,
        platform: platform,
        tokenFirebase: tokenFirebase);
    return loginInfo;
  }

  Future<bool> logOut() async {
    try {
      final isSuccess = await _authApi.logOut();
      if (isSuccess) {
        await _authLocalStorage.clearLoginInfo();
      }
      return isSuccess;
    } catch (e) {
      throw LogOutFailure();
    }
  }

  Future<bool> initApp() async {
    await _authApi.getToken();
    return _authApi.isLogin;
  }

  Future<PhoneNumberVerificationInfo?> sendOTP(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final verificationCompleter = Completer<PhoneNumberVerificationInfo>();
    await auth.verifyPhoneNumber(
      phoneNumber: '+84${phoneNumber.substring(1)}',
      verificationCompleted: (PhoneAuthCredential credential) {
        log("sendOTP - OTP Sent successfully");
      },
      verificationFailed: (FirebaseAuthException e) {
        log("sendOTP - OTP Sent Failed");
        throw e;
      },
      codeSent: (verificationId, forceResendingToken) {
        log("sendOTP - OTP Sent success: forceResendingToken - $forceResendingToken");
        verificationCompleter.complete(PhoneNumberVerificationInfo(
          forceResendingToken: forceResendingToken,
          verificationId: verificationId,
        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log("sendOTP - codeAutoRetrievalTimeout");
      },
    );
    log("sendOTP - OTP Sent to +84${phoneNumber.substring(1)}");
    return await verificationCompleter.future;
  }

  Future<PhoneNumberVerificationInfo?> resendOTP(
    String phoneNumber,
    int? forceResendingToken,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final verificationCompleter = Completer<PhoneNumberVerificationInfo>();
    await auth.verifyPhoneNumber(
      forceResendingToken: forceResendingToken,
      phoneNumber: '+84${phoneNumber.substring(1)}',
      verificationCompleted: (PhoneAuthCredential credential) {
        log("sendOTP - OTP Sent successfully");
      },
      verificationFailed: (FirebaseAuthException e) {
        log("sendOTP - OTP Sent Failed");
        throw e;
      },
      codeSent: (verificationId, forceResendingToken) {
        log("sendOTP - OTP Sent success: forceResendingToken - $forceResendingToken");
        verificationCompleter.complete(PhoneNumberVerificationInfo(
          forceResendingToken: forceResendingToken,
          verificationId: verificationId,
        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log("sendOTP - codeAutoRetrievalTimeout");
      },
    );
    log("sendOTP - OTP Sent to +84${phoneNumber.substring(1)}");
    return await verificationCompleter.future;
  }

  Future verifyOTP(String verificationId, String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      FirebaseAuth auth = FirebaseAuth.instance;

      await auth.signInWithCredential(credential);
      log("verifyOTP - OTP Verified");
      await auth.signOut();
    } catch (e) {
      log("verifyOTP - OTP Verification Failed");
      throw Exception();
    }
  }
}
