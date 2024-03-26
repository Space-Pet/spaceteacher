import 'package:flutter/material.dart';
import 'package:teacher/src/screens/authentication/login/view/login_screen.dart';
import 'package:teacher/src/screens/home/view/home_screen.dart';
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
    }
    return _getPage(
      Container(),
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
