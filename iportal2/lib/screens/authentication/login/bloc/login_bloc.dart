import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/domain_saver.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.context,
    required this.authRepository,
    required this.currentUserBloc,
    required this.userRepository,
  }) : super(LoginState(
          domain: '',
          userName: '',
          password: '',
          isSaveLoginInfo: false,
          isSuccess: false,
          showError: false,
          deviceInfo: DeviceInfo.empty(),
        )) {
    on<LoginUsernameChanged>(_onUserNameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<PasswordVisibility>(_onPasswordVisibility);
    on<LoginSubmitted>(_onLogin);
    on<LoginQR>(_onLoginQR);

    on<InitDomain>(_initDomain);
    add(const InitDomain());

    on<InitDeviceInfo>(_initDeviceInfo);
    add(const InitDeviceInfo());
  }

  final AuthRepository authRepository;
  final BuildContext context;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  void _initDomain(InitDomain event, Emitter<LoginState> emit) async {
    final domain = await SingletonDomainSaver().getDomain();
    emit(state.copyWith(domain: domain));
  }

  void _initDeviceInfo(InitDeviceInfo event, Emitter<LoginState> emit) async {
    final firebaseMessaging = FirebaseMessaging.instance;
    final fcmToken = await firebaseMessaging.getToken();
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final isAndroid = Platform.isAndroid;

    if (isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;

      emit(state.copyWith(
        deviceInfo: DeviceInfo(
          deviceId: androidInfo.id,
          model: androidInfo.model,
          platform: 'Android',
          tokenFirebase: fcmToken ?? '',
        ),
      ));
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;

      emit(state.copyWith(
        deviceInfo: DeviceInfo(
          deviceId: iosInfo.identifierForVendor ?? '',
          model: iosInfo.model,
          platform: iosInfo.systemName,
          tokenFirebase: fcmToken ?? '',
        ),
      ));
    }
  }

  void _onPasswordVisibility(
      PasswordVisibility event, Emitter<LoginState> emit) {
    final currentPasswordVisible = state.passwordVisible;
    emit(state.copyWith(passwordVisible: !currentPasswordVisible));
  }

  void _onUserNameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final newUserName = event.userName;
    final newState = state.copyWith(userName: newUserName);
    emit(newState);
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final newPassword = event.password;
    final newState = state.copyWith(password: newPassword);
    emit(newState);
  }

  Future<void> _onLogin(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    try {
      // [TEST] - clear before commit
      // final userName = kDebugMode ? '02031230009' : state.userName;
      // final password = kDebugMode ? 'apel1z' : state.password;
      final userName = state.userName;
      final password = state.password;
      final deviceInfo = state.deviceInfo;

      emit(state.copyWith(status: LoginStatus.loading));

      if (userName.isEmpty || password.isEmpty) {
        emit(state.copyWith(status: LoginStatus.emptyLoginInfoError));
        return;
      }

      final user = await authRepository.login(
        userName: userName,
        password: password,
        deviceId: deviceInfo.deviceId,
        model: deviceInfo.model,
        platform: deviceInfo.platform,
        tokenFirebase: deviceInfo.tokenFirebase,
      );

      final localChildren = user.children
          .map((e) => e.toLocalChildren(
                isDefaultActive: user.pupil_id == e.pupil_id,
              ))
          .toList();

      final localUser = LocalIPortalProfile(
        name: user.name,
        user_key: user.user_key,
        user_id: user.user_id,
        type: user.type,
        type_text: user.type_text,
        children: localChildren,
      );

      userRepository.saveUser(localUser);
      currentUserBloc.add(CurrentUserUpdated(user: localUser));
      emit(state.copyWith(status: LoginStatus.success));
    } on LoginFailure catch (e) {
      emit(state.copyWith(
          status: LoginStatus.failure, failureMessage: e.message));
    } catch (_) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        failureMessage: 'Có lỗi xảy ra, vui lòng thử lại',
      ));
    }
  }

  void _onLoginQR(LoginQR event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      final deviceInfo = state.deviceInfo;

      final user = await authRepository.loginQR(
        qrCode: event.qrCode,
        deviceId: deviceInfo.deviceId,
        model: deviceInfo.model,
        platform: deviceInfo.platform,
        tokenFirebase: deviceInfo.tokenFirebase,
      );

      final localChildren = user.children
          .map((e) =>
              e.toLocalChildren(isDefaultActive: user.pupil_id == e.pupil_id))
          .toList();

      final localUser = LocalIPortalProfile(
        name: user.name,
        user_key: user.user_key,
        user_id: user.user_id,
        type: user.type,
        type_text: user.type_text,
        children: localChildren,
      );

      userRepository.saveUser(localUser);
      currentUserBloc.add(CurrentUserUpdated(user: localUser));
      return emit(state.copyWith(status: LoginStatus.success));
    } on LoginFailure catch (e) {
      emit(state.copyWith(
          status: LoginStatus.failure, failureMessage: e.message));
    } catch (_) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        failureMessage: 'Có lỗi xảy ra, vui lòng thử lại',
      ));
    }
  }
}
