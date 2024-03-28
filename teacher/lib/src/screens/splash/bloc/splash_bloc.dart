import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/src/settings/settings.dart';
import 'package:teacher/src/utils/user_manager.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final Settings setting;
  SplashBloc({
    required this.setting,
  }) : super(const SplashState()) {
    on<CheckSession>(_checkSession);
  }

  Future<void> _checkSession(
      CheckSession event, Emitter<SplashState> emit) async {
    try {
      await UserManager.instance.loadSession(setting);
      final user = await UserManager.instance.getUser(setting);

      if (isNullOrEmpty(user)) {
        await UserManager.instance.logout(setting: setting);
        return emit(
          state.copyWith(status: SplashStatus.hasNotLogin),
        );
      }
      emit(
        state.copyWith(status: SplashStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(
            status: SplashStatus.failure,
            errorMessage: "SplashScreen -> CheckSession() -> $e"),
      );
    }
  }
}
