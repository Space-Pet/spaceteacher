import 'dart:async';

import 'package:core/core.dart';
import 'package:core/presentation/screens/domain/domain_saver.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.authRepository,
    required this.domainSaver,
  }) : super(const LoginState()) {
    on<LoginDomainSave>(_onDomainSave);
    on<LoginWith365>(_loginWithOffice365);
  }
  final DomainSaver domainSaver;
  final AuthRepository authRepository;

  Future<void> _loginWithOffice365(
      LoginWith365 event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      final user = await authRepository.loginWith365();
      Log.d('User: $user');
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      Log.e('$e', name: "Login Error AuthRepository -> loginWithOffice365()");
      emit(state.copyWith(status: LoginStatus.failure));
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
      return await domainSaver.saveDomain(domain: domain);
    });
    if(saved){
      if(!emit.isDone){
        emit(state.copyWith(status: LoginStatus.readyToSubmit, cachedDomain: event.domain));
      }
    }
  }
}
