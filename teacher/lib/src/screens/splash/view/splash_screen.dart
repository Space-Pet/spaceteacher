import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/app_main_layout.dart';

import 'package:teacher/src/screens/authentication/login/view/login_screen.dart';
import 'package:teacher/src/screens/splash/bloc/splash_bloc.dart';
import 'package:teacher/src/settings/settings.dart';
import 'package:teacher/src/utils/extension_context.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashBloc _splashBloc = SplashBloc(
    setting: Injection.get<Settings>(),
  )..add(CheckSession());

  @override
  void initState() {
    // UserManager.instance.logout(
    //     setting: Injection.get<Setting>(),
    //     userRepository: Injection.get<UserRepository>());
    super.initState();
  }

  @override
  void dispose() {
    _splashBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      bloc: _splashBloc,
      listener: (context, state) {
        switch (state.status) {
          case SplashStatus.initial:
            // TODO: Handle this case.
            break;
          case SplashStatus.hasNotLogin:
            context.pushReplacement(LoginScreen.routeName);
            break;
          case SplashStatus.success:
            context.pushReplacement(AppMainLayout.routeName);
            break;
          case SplashStatus.failure:
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: 200,
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: Assets.logoPng.provider(),
                  //   ),
                  // ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const CircularProgressIndicator()
              ],
            ),
          ),
        );
      },
    );
  }
}
