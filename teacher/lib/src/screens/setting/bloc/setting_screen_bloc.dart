import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/src/settings/settings.dart';
import 'package:teacher/src/utils/user_manager.dart';

part 'setting_screen_event.dart';
part 'setting_screen_state.dart';

class SettingScreenBloc extends Bloc<SettingScreenEvent, SettingScreenState> {
  SettingScreenBloc({required this.settings})
      : super(const SettingScreenState()) {
    on<SettingScreenLoggedOut>(_onLogout);
  }
  final Settings settings;

  Future<void> _onLogout(
    SettingScreenLoggedOut event,
    Emitter<SettingScreenState> emit,
  ) async {
    final UserManager userManager = UserManager.instance;
    emit(
      state.copyWith(logoutStatus: SettingScreenStatus.loading),
    );

    try {
      await userManager.logout(setting: settings);

      emit(
        state.copyWith(
          logoutStatus: SettingScreenStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(logoutStatus: SettingScreenStatus.failure),
      );
      rethrow;
    }
  }
}
