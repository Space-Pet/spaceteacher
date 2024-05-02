import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  }) : super(const LoginState(
            userName: '',
            password: '',
            isSaveLoginInfo: false,
            isSuccess: false,
            showError: false)) {
    on<LoginUsernameChanged>(_onUserNameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<PasswordVisibility>(_onPasswordVisibility);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginQR>(_onLoginQR);
  }

  final AuthRepository authRepository;
  final BuildContext context;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

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

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final userName = state.userName;
      final password = state.password;
      emit(state.copyWith(status: LoginStatus.loading));

      if (userName.isEmpty || password.isEmpty) {
        emit(state.copyWith(status: LoginStatus.emptyLoginInfoError));
        return;
      }

      final user = await authRepository.login(
        userName: userName,
        password: password,
        isSaveLoginInfo: state.isSaveLoginInfo,
      );

      final featuresLocal = await userRepository.getFeatures();
      final listFeatures = featuresLocal
          ?.firstWhere(
            (element) => element.user_key == user.user_key,
            orElse: () => LocalFeatures(user_key: '', features: []),
          )
          .features;

      final pinnedAlbumIdList = featuresLocal
          ?.firstWhere(
            (element) => element.user_key == user.user_key,
            orElse: () => LocalFeatures(
              user_key: '',
              features: [],
              pinnedAlbumIdList: [],
            ),
          )
          .pinnedAlbumIdList;

      final userWithFeatures = user.copyWith(
        features: (listFeatures ?? []).isNotEmpty
            ? listFeatures
            : (user.isKinderGarten() ? preSFeatures : hihgSFeatures),
        pinnedAlbumIdList: pinnedAlbumIdList,
      );

      userRepository.saveUser(userWithFeatures);
      currentUserBloc.add(CurrentUserUpdated(user: userWithFeatures));
      return emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure));
      rethrow;
    }
  }

  void _onLoginQR(LoginQR event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      final user = await authRepository.loginQR(
          qrCode: event.qrCode,
          deviceId: event.deviceId,
          model: event.model,
          platform: event.platform,
          tokenFirebase: event.tokenFirebase);
      final featuresLocal = await userRepository.getFeatures();
      final listFeatures = featuresLocal
          ?.firstWhere(
            (element) => element.user_key == user.user_key,
            orElse: () => LocalFeatures(user_key: '', features: []),
          )
          .features;

      final pinnedAlbumIdList = featuresLocal
          ?.firstWhere(
            (element) => element.user_key == user.user_key,
            orElse: () => LocalFeatures(
              user_key: '',
              features: [],
              pinnedAlbumIdList: [],
            ),
          )
          .pinnedAlbumIdList;

      final userWithFeatures = user.copyWith(
        features: (listFeatures ?? []).isNotEmpty
            ? listFeatures
            : (user.isKinderGarten() ? preSFeatures : hihgSFeatures),
        pinnedAlbumIdList: pinnedAlbumIdList,
      );

      userRepository.saveUser(userWithFeatures);
      currentUserBloc.add(CurrentUserUpdated(user: userWithFeatures));
      return emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure));
      rethrow;
    }
  }
}
