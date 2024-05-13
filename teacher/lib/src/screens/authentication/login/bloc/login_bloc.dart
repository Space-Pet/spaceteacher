import 'dart:async';

import 'package:core/core.dart';
import 'package:core/presentation/screens/domain/domain_saver.dart';
import 'package:equatable/equatable.dart';
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
  }) : super(const LoginState()) {
    on<LoginDomainSave>(_onDomainSave);
    on<LoginWith365>(_loginWithOffice365);
  }

  final AuthRepository authRepository;
  final UserRepository userRepository;

  Future<void> _loginWithOffice365(
      LoginWith365 event, Emitter<LoginState> emit) async {
    try {
      final UserManagerBloc userManagerBloc =
          UserManagerBloc(userRepository: userRepository);

      emit(state.copyWith(status: LoginStatus.loading));

      final user = await authRepository.loginWith365();

      await userRepository.saveUserInfo(user ?? UserInfo());
      await UserManager.instance.loadSession(Injection.get<Settings>());
      await Injection.get<Settings>().saveIsFirstTime(false);
      userManagerBloc.add(const UserManagerGetUser());

      Log.d('User: $user');
      return emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      Log.e('$e', name: "Login Error AuthRepository -> loginWithOffice365()");
      emit(state.copyWith(status: LoginStatus.failure));
      rethrow;
    }
  }

  final domainInputDebouncer = Debouncer<bool>(milliseconds: 500);
  Future<void> _onDomainSave(LoginDomainSave event, Emitter<LoginState> emit) async {
    if(state.cachedDomain.isNotEmpty && event.domain != state.cachedDomain){
      // clear cached domain
      emit(state.copyWith(status: LoginStatus.init, cachedDomain: ''));
    }
    final saved = await domainInputDebouncer.runAsync(() async {
      final domain = event.domain;
      final domainSaver = DomainSaver();
      return await domainSaver.saveDomain(domain: domain);
    });
    if(saved){
      if(!emit.isDone){
        emit(state.copyWith(status: LoginStatus.readyToSubmit, cachedDomain: event.domain));
      }
    }
  }
}
