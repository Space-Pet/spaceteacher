import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app_main_layout.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/screens/authentication/login/view/login_screen.dart';
import 'package:teacher/src/settings/settings.dart';
import 'package:teacher/src/splash/bloc/splash_cubit.dart';
import 'package:teacher/src/splash/curved_splash_screen.dart';
import 'package:teacher/src/splash/splash_content.dart';
import 'package:core/presentation/extentions/extension_context.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  static const routeName = 'loading';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final cubit = SplashCubit(settings: Injection.get<Settings>());

  @override
  void initState() {
    cubit.checkAndNavigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(
        settings: Injection.get<Settings>(),
      ),
      child: BlocListener<SplashCubit, SplashState>(
        bloc: cubit,
        listener: (context, state) {
          switch (state.status) {
            case SplashStatus.logined:
              context.pushReplacement(AppMainLayout.routeName);
              break;

            case SplashStatus.firstLogin:
              context.pushReplacement(
                CurvedSplashScreen.routeName,
                arguments: {
                  'screensLength': splashContent.length,
                  'screenBuilder': (index) {
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
                  'nextText': AppStrings.nextText,
                  'skipText': AppStrings.skipText,
                },
              );
              break;

            case SplashStatus.unLogined:
              context.pushReplacement(LoginScreen.routeName);
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
