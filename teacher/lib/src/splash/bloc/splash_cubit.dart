import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/repository/auth_repository/auth_repositories.dart';

import 'package:teacher/src/settings/settings.dart';
import 'package:teacher/src/utils/user_manager.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final Settings settings;
  SplashCubit({required this.settings}) : super(const SplashState()) {
    appStartLoading();
  }

  Future<bool> checkLoggedIn() async {
    final res = await UserManager.instance.getUser(settings);

    if (!isNullOrEmpty(res)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> checkAndNavigate() async {
    final bool isFirstTime = await settings.getIsFirstTime();

    final isLogin = await checkLoggedIn();

    if (isFirstTime == true) {
      emit(state.copyWith(status: SplashStatus.firstLogin));
    } else {
      if (isLogin) {
        emit(state.copyWith(status: SplashStatus.logined));

        final localUser = await UserManager.instance.getUser(settings);

        if (localUser != null) {
          await settings.saveUserModel(localUser);
        }
      } else {
        emit(state.copyWith(status: SplashStatus.unLogined));
      }
    }
  }

  Future<void> appStartLoading() async {
    await checkAndNavigate();
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> splashCleanToken(
      Settings settings, AuthRepository authRepository) async {
    await UserManager.instance
        .logout(setting: settings, authRepository: authRepository);
  }
}
