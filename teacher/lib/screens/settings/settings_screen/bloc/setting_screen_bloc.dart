import 'package:core/core.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'setting_screen_event.dart';
part 'setting_screen_state.dart';

class SettingScreenBloc extends Bloc<SettingScreenEvent, SettingScreenState> {
  SettingScreenBloc({
    required this.authRepository,
    required this.userRepository,
    required this.appFetchApiRepo,
    required this.currentUserBloc,
  }) : super(const SettingScreenState()) {
    on<SettingScreenLoggedOut>(_onLogout);
    on<TurnOnOffNoti>(_onTurnOffNoti);
  }

  final AuthRepository authRepository;
  final UserRepository userRepository;
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  Future<void> _onTurnOffNoti(
    TurnOnOffNoti event,
    Emitter<SettingScreenState> emit,
  ) async {
    final user = currentUserBloc.state.user;

    final headers = {
      'School-Id': user.school_id,
      'School-Brand': user.school_brand,
    };

    try {
      final data = await appFetchApiRepo.turnOffNoti(
        pushNotify: event.pushNotify,
        headers: headers,
      );
      if (data!['code'] == 200) {
        emit(state.copyWith(
          logoutStatus: SettingScreenStatus.turnOffNotiSuccess,
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(logoutStatus: SettingScreenStatus.failure),
      );
      rethrow;
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
        final domainSaver = Injection.get<DomainSaver>();
        await domainSaver.clearDomain();
        await userRepository.logOut();
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
