import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
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
      // [Debug]
      // final userName = 'ph0723210020';
      // final password = 'uko7ap';
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

      userRepository.saveUser(user);

      currentUserBloc.add(CurrentUserUpdated(user: user));

      return emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      print("LoginBloc error: $e");
      emit(state.copyWith(status: LoginStatus.failure));
      rethrow;
    }
  }
}
