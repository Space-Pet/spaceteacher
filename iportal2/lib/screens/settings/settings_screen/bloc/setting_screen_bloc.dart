import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iportal2/app_config/domain_saver.dart';
import 'package:repository/repository.dart';

part 'setting_screen_event.dart';
part 'setting_screen_state.dart';

class SettingScreenBloc extends Bloc<SettingScreenEvent, SettingScreenState> {
  SettingScreenBloc({
    required this.authRepository,
    required this.userRepository,
    required this.appFetchApiRepo,
  }) : super(const SettingScreenState()) {
    on<SettingScreenLoggedOut>(_onLogout);
    on<ChangePassword>(_onChangePassword);
  }
  final AppFetchApiRepository appFetchApiRepo;
  final AuthRepository authRepository;
  final UserRepository userRepository;

  Future<void> _onChangePassword(
    ChangePassword event,
    Emitter<SettingScreenState> emit,
  ) async {
    emit(
      state.copyWith(logoutStatus: SettingScreenStatus.loading),
    );
    final data = await appFetchApiRepo.changePassword(
      password: event.password,
      currentPassword: event.currentPassword,
      passwordConfirmation: event.passwordConfirmation,
    );
    if (data?['code'] == 200) {
      emit(state.copyWith(
          logoutStatus: SettingScreenStatus.successChangePassword));
    } else {
      emit(state.copyWith(
          logoutStatus: SettingScreenStatus.failureChangePassword,
          message: data?['message']));
      print('oo: ${data?['message']}');
    }
  }

  Future<void> _onLogout(
    SettingScreenLoggedOut event,
    Emitter<SettingScreenState> emit,
  ) async {
    emit(
      state.copyWith(logoutStatus: SettingScreenStatus.loading),
    );

    try {
      final isSuccess = await authRepository.logOut();
      if (isSuccess) {
        final domainSaver = SingletonDomainSaver();
        await domainSaver.clearDomain();
        await userRepository.clearLocalUser();
        emit(
          state.copyWith(logoutStatus: SettingScreenStatus.success),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(logoutStatus: SettingScreenStatus.failure),
      );
      rethrow;
    }
  }
}
