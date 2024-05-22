import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/domain_saver.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:local_data_source/local_data_source.dart';
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
    print('fcm: $fcmToken');
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

      final dataLocal = await userRepository.getFeatures();
      final listFeatures = dataLocal
          ?.firstWhere(
            (element) => element.user_key == user.user_key,
            orElse: () => LocalFeatures(user_key: '', features: []),
          )
          .features;

      final featuresByGrade =
          user.isKinderGarten() ? preSFeatures : hihgSFeatures;

      final featuresByType = user.isStudent()
          ? featuresByGrade
              .where((element) => element.key != FeatureKey.survey)
              .toList()
          : featuresByGrade;

      final pinnedAlbumIdList = dataLocal
          ?.firstWhere(
            (element) => element.user_key == user.user_key,
            orElse: () => LocalFeatures(
              user_key: '',
              features: [],
              pinnedAlbumIdList: [],
            ),
          )
          .pinnedAlbumIdList;

      final bgSchoolBrand = SchoolBrand.values
          .firstWhere((element) => element.value == user.school_brand);

      final userLocal = user.copyWith(
        features: isNullOrEmpty(listFeatures) ? listFeatures : featuresByType,
        pinnedAlbumIdList: pinnedAlbumIdList,
        background: bgSchoolBrand,
      );

      userRepository.saveUser(userLocal);
      currentUserBloc.add(CurrentUserUpdated(user: userLocal));
      return emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure));
      rethrow;
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
      final dataLocal = await userRepository.getFeatures();

      final listFeatures = dataLocal
          ?.firstWhere(
            (element) => element.user_key == user.user_key,
            orElse: () => LocalFeatures(user_key: '', features: []),
          )
          .features;

      final featuresByGrade =
          user.isKinderGarten() ? preSFeatures : hihgSFeatures;

      final featuresByType = user.isStudent()
          ? featuresByGrade
              .where((element) => element.key != FeatureKey.survey)
              .toList()
          : featuresByGrade;

      final pinnedAlbumIdList = dataLocal
          ?.firstWhere(
            (element) => element.user_key == user.user_key,
            orElse: () => LocalFeatures(
              user_key: '',
              features: [],
              pinnedAlbumIdList: [],
            ),
          )
          .pinnedAlbumIdList;

      final bgSchoolBrand = SchoolBrand.values
          .firstWhere((element) => element.value == user.school_brand);

      final userLocal = user.copyWith(
        features:
            (listFeatures ?? []).isNotEmpty ? listFeatures : featuresByType,
        pinnedAlbumIdList: pinnedAlbumIdList,
        background: bgSchoolBrand,
        children: user.children
            .map((e) => e.copyWith(isActive: user.pupil_id == e.pupil_id))
            .toList(),
      );

      userRepository.saveUser(userLocal);
      currentUserBloc.add(CurrentUserUpdated(user: userLocal));
      return emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure));
      rethrow;
    }
  }
}
