import 'dart:async';

import 'package:core/core.dart';
import 'package:core/presentation/screens/domain/domain_saver.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.authRepository,
    required this.userRepository,
    required this.currentUserBloc,
    required this.domainSaver,
  }) : super(const LoginState()) {
    on<LoginDomainSave>(_onDomainSave);
    on<LoginWith365>(_loginWithOffice365);
  }
  final DomainSaver domainSaver;
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final CurrentUserBloc currentUserBloc;

  Future<void> _loginWithOffice365(
      LoginWith365 event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      final user = await authRepository.loginWith365();

      if (user == null) {
        emit(state.copyWith(status: LoginStatus.failure));
        return;
      }

      final isKinderGarten = user.isKinderGarten();
      final loggedUsers = await userRepository.getLoggedUsers() ?? [];

      final matchUser = loggedUsers.firstWhere(
          (element) => element.user_key == user.userKey,
          orElse: () => LoggedUser.empty());

      final featuresByGrade =
          isKinderGarten ? preSFeatures : hihgSFeatures;

      final bgSchoolBrand = SchoolBrand.values
          .firstWhere((element) => element.value == user.schoolBrand);

      final localTeacherInfo = LocalTeacher(
        name: user.name,
        user_key: user.userKey,
        teacher_id: user.teacherId,
        school_id: user.schoolId,
        user_id: user.userId,
        school_brand: user.schoolBrand,
        features: matchUser.features.isNotEmpty
            ? matchUser.features
            : featuresByGrade,
        background: bgSchoolBrand,
        pinnedAlbumIdList: matchUser.pinnedAlbumIdList,
        isKinderGarten: isKinderGarten,
      );

      userRepository.saveUser(localTeacherInfo);
      currentUserBloc.add(CurrentUserUpdated(user: localTeacherInfo));

      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      Log.e('$e', name: "Login Error AuthRepository -> loginWithOffice365()");
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }

  final domainInputDebouncer = Debouncer<bool>(milliseconds: 500);
  Future<void> _onDomainSave(
      LoginDomainSave event, Emitter<LoginState> emit) async {
    if (state.cachedDomain.isNotEmpty && event.domain != state.cachedDomain) {
      // clear cached domain
      emit(state.copyWith(status: LoginStatus.init, cachedDomain: ''));
    }
    final saved = await domainInputDebouncer.runAsync(() async {
      final domain = event.domain;
      return await domainSaver.saveDomain(domain: domain);
    });
    if (saved) {
      if (!emit.isDone) {
        emit(state.copyWith(
            status: LoginStatus.readyToSubmit, cachedDomain: event.domain));
      }
    }
  }
}
