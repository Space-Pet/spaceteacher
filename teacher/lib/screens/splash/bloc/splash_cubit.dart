import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(
      {required this.authRepository,
      required this.userRepository,
      required this.currentUserBloc})
      : super(const SplashState()) {
    appStartLoading();
  }

  final AuthRepository authRepository;
  final UserRepository userRepository;
  final CurrentUserBloc currentUserBloc;

  Future<bool> checkLoggedIn() async {
    // Thực hiện kiểm tra đăng nhập bằng AuthRepository
    final isLogin = await authRepository.initApp();
    return isLogin;
  }

  Future<void> checkAndNavigate() async {
    await Hive.initFlutter();
    final box = await Hive.openBox('boxFistTime');
    bool isFistTime = box.get('boxFistTime', defaultValue: true);
    final isLogin = await checkLoggedIn();

    if (isFistTime) {
      emit(state.copyWith(status: SplashStatus.firstLogin));
    } else {
      if (isLogin) {
        emit(state.copyWith(status: SplashStatus.logined));
        final localUser = await userRepository.getLocalUser();

        if (localUser != null) {
          currentUserBloc.add(CurrentUserUpdated(user: localUser));
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

  Future<void> splashCleanToken() async {
    await authRepository.logOut();
  }
}
