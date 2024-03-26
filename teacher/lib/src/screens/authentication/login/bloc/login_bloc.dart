import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/model/user_model.dart';
import 'package:teacher/repository/auth_repository/auth_repositories.dart';
import 'package:teacher/repository/user_repository/user_repositories.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.authRepository,
    // required this.currentUserBloc,
    required this.userRepository,
  }) : super(const LoginState(
            userName: '',
            password: '',
            isSaveLoginInfo: false,
            isSuccess: false,
            showError: false)) {
    on<PasswordVisibility>(_onPasswordVisibility);
    on<LoginButtonPressed>(_onSubmitted);
  }

  final AuthRepository authRepository;
  // final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  void _onPasswordVisibility(
      PasswordVisibility event, Emitter<LoginState> emit) {
    final currentPasswordVisible = state.passwordVisible;
    emit(state.copyWith(passwordVisible: !currentPasswordVisible));
  }

  //
  Future<void> _onSubmitted(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final userName = event.userName;
      final password = event.password;
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
        // isSaveLoginInfo: state.isSaveLoginInfo,
      );

      userRepository.saveUserInfo(user ?? UserInfo());

      // currentUserBloc.add(CurrentUserUpdated(user: user));

      return emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      print("error: $e");
      emit(state.copyWith(status: LoginStatus.failure));
      rethrow;
    }
  }
}
