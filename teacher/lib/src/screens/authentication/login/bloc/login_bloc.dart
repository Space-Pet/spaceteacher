import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/common_bloc/user_manager/bloc/user_manager_bloc.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/repository/auth_repository/auth_repositories.dart';
import 'package:teacher/repository/user_repository/user_repositories.dart';
import 'package:teacher/src/settings/settings.dart';
import 'package:teacher/src/utils/user_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.authRepository,
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
      final UserManagerBloc userManagerBloc =
          UserManagerBloc(userRepository: userRepository);
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

      await userRepository.saveUserInfo(user ?? UserInfo());
      await UserManager.instance.loadSession(Injection.get<Settings>());
      userManagerBloc.add(const UserManagerGetUser());
      // userManagerBloc.add(UserManagerUpdated(userInfo: user ?? UserInfo()));
      Log.d('User: $user');
      return emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      print("error: $e");
      emit(state.copyWith(status: LoginStatus.failure));
      rethrow;
    }
  }
}
