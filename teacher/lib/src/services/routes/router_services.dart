import 'package:flutter/material.dart';
import 'package:teacher/app_main_layout.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/src/screens/authentication/login/view/login_screen.dart';
import 'package:teacher/src/screens/home/view/home_screen.dart';
import 'package:teacher/src/screens/profile/view/profile_screen.dart';
import 'package:teacher/src/screens/setting/view/setting_screen.dart';
import 'package:teacher/src/screens/splash/view/splash_screen.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return _getPage(const LoginScreen());
      case HomeScreen.routeName:
        return _getPage(const HomeScreen());
      case SplashScreen.routeName:
        return _getPage(const SplashScreen());
      case AppMainLayout.routeName:
        return _getPage(const AppMainLayout());
      case ProfileScreen.routeName:
        final args = settings.arguments as Map?;
        UserInfo? userInfo;
        if (args != null) {
          userInfo = args['userInfo'];
        }
        return _getPage(
          ProfileScreen(
            userInfo: userInfo ?? UserInfo(),
          ),
        );

      case SettingScreen.routeName:
        return _getPage(const SettingScreen());
    }
    return _getPage(
      const AppMainLayout(),
    );
  }

  MaterialPageRoute _getPage(
    Widget page, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) =>
      MaterialPageRoute(
        builder: (context) => page,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      );
}
