import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/app_main_layout.dart';
import 'package:iportal2/screens/authentication/login/view/login_screen.dart';
import 'package:iportal2/screens/splash/bloc/splash_cubit.dart';
import 'package:iportal2/screens/splash/curved_splash_screen.dart';
import 'package:iportal2/screens/splash/splash_content.dart';
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
        
              context.pushReplacement(AppMainLayout());
              break;

            case SplashStatus.firstLogin:
              context.pushReplacement(CurvedSplashScreen(
                screensLength: splashContent.length,
                screenBuilder: (index) {
                  return SplashContent(
                    title1: splashContent[index]['title1']!,
                    title2: splashContent[index]['title2']!,
                    title2Red: splashContent[index]['title2Red']!,
                    title3: splashContent[index]['title3']!,
                    title3Red: splashContent[index]['title3Red']!,
                    image: splashContent[index]['image']!,
                    text1: splashContent[index]['text1']!,
                    text2: splashContent[index]['text2'],
                    index: index,
                  );
                },
              ));
              break;

            case SplashStatus.unLogined:
              context.pushReplacement(const LoginScreen());
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
