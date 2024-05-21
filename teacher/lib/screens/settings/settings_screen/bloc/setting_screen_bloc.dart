import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/app_config/domain_saver.dart';
import 'package:repository/repository.dart';

part 'setting_screen_event.dart';
part 'setting_screen_state.dart';

class SettingScreenBloc extends Bloc<SettingScreenEvent, SettingScreenState> {
  SettingScreenBloc({
    required this.authRepository,
    required this.userRepository,
  }) : super(const SettingScreenState()) {
    on<SettingScreenLoggedOut>(_onLogout);
  }

  final AuthRepository authRepository;
  final UserRepository userRepository;

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