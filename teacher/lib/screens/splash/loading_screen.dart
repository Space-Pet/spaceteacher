import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/app_main_layout.dart';
import 'package:teacher/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:teacher/screens/authentication/domain/view/domain_screen.dart';
import 'package:teacher/screens/splash/bloc/splash_cubit.dart';
import 'package:teacher/screens/splash/curved_splash_screen.dart';
import 'package:teacher/screens/splash/splash_content.dart';
import 'package:repository/repository.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});
  static const routeName = 'loading';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(
        authRepository: context.read<AuthRepository>(),
        userRepository: context.read<UserRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          switch (state.status) {
            case SplashStatus.logined:
              context.pushReplacement(const AppMainLayout());
              break;

            case SplashStatus.firstLogin:
              context.pushReplacement(CurvedSplashScreen(
                screensLength: splashContent.length,
                screenBuilder: (index) {
                  final content = splashContent[index];
                  return SplashContent(
                    title1: content['title1']!,
                    title2: content['title2']!,
                    title2Red: content['title2Red']!,
                    title3: content['title3']!,
                    title3Red: content['title3Red']!,
                    image: content['image']!,
                    text1: content['text1']!,
                    text2: content['text2'],
                    index: index,
                  );
                },
              ));
              break;

            case SplashStatus.unLogined:
              context.pushReplacement(LoginScreen());
              break;
            default:
          }
        },
        child: const LoadingView(),
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
