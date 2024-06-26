import 'package:flutter/material.dart';
import 'package:iportal2/screens/bus/bus_screen.dart';
import 'package:iportal2/screens/exercise_notice/exercise_screen.dart';
import 'package:iportal2/screens/home/home_screen.dart';
import 'package:iportal2/screens/leave/leave_application_screen.dart';
import 'package:iportal2/screens/leave/on_leave_screen.dart';
import 'package:iportal2/screens/authentication/login/view/login_screen.dart';
import 'package:iportal2/screens/phone_book/phone_book_screen.dart';
import 'package:iportal2/screens/register_notebook/register_notebook_screen.dart';
import 'package:iportal2/screens/splash/loading_screen.dart';

class CustomRouter {
  static PageRouteBuilder transitionAnimation({
    required Widget child,
    required String routeName,
  }) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      pageBuilder: (c, a1, a2) => child,
      transitionsBuilder: (c, anim, a2, child) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(anim),
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  static PageRouteBuilder<dynamic>? onGenerateRoute(RouteSettings? settings) {
    switch (settings!.name) {
      case LoginScreen.routeName:
        return transitionAnimation(
          routeName: LoginScreen.routeName,
          child: const LoginScreen(),
        );

      case LoadingScreen.routeName:
        return transitionAnimation(
          routeName: LoadingScreen.routeName,
          child: const LoadingScreen(),
        );

      case HomeScreen.routeName:
        return transitionAnimation(
          routeName: HomeScreen.routeName,
          child: const HomeScreen(),
        );

      case RegisterNoteBoookScreen.routeName:
        return transitionAnimation(
          child: const RegisterNoteBoookScreen(),
          routeName: RegisterNoteBoookScreen.routeName,
        );

      case OnLeaveScreen.routeName:
        return transitionAnimation(
          child: const OnLeaveScreen(),
          routeName: OnLeaveScreen.routeName,
        );

      case PhoneBookScreen.routeName:
        return transitionAnimation(
          child: const PhoneBookScreen(),
          routeName: PhoneBookScreen.routeName,
        );

      case LeaveApplicationScreen.routeName:
        return transitionAnimation(
          child: const LeaveApplicationScreen(),
          routeName: LeaveApplicationScreen.routeName,
        );

      case ExerciseScreen.routeName:
        return transitionAnimation(
          routeName: ExerciseScreen.routeName,
          child: const ExerciseScreen(),
        );

      case BusScreen.routeName:
        return transitionAnimation(
            child: const BusScreen(), routeName: BusScreen.routeName);

      default:
        assert(false, 'Need to implement ${settings.name}');
        return null;
    }
  }
}

extension Navigation on BuildContext {
  Future<dynamic> push(Widget newScreen) {
    return Navigator.push(
      this,
      CustomRouter.transitionAnimation(child: newScreen, routeName: ''),
    );
  }

  Future<dynamic> backToScreen(Widget newScreen) {
    return Navigator.pushAndRemoveUntil(
      this,
      CustomRouter.transitionAnimation(
        child: newScreen,
        routeName: '',
      ),
      (Route<dynamic> route) => false,
    );
  }

  Future<dynamic> pushReplacement(Widget newScreen) {
    return Navigator.pushReplacement(
      this,
      CustomRouter.transitionAnimation(
        child: newScreen,
        routeName: '',
      ),
    );
  }

  pushReplacementNamed({
    required String routeName,
    Object? arguments,
  }) {
    Navigator.pushReplacementNamed(this, routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementUntil(Widget newScreen) {
    return Navigator.pushAndRemoveUntil(
      this,
      CustomRouter.transitionAnimation(
        child: newScreen,
        routeName: '',
      ),
      (route) => false,
    );
  }

  pushNamed({
    required String routeName,
    Object? arguments,
  }) {
    Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  pop<T extends Object?>([T? result]) {
    Navigator.pop(this, result);
  }

  popUntil({
    required String routeName,
  }) {
    Navigator.popUntil(
      this,
      ModalRoute.withName(routeName),
    );
  }

  pushNamedAndRemoveUntil({
    required String newRouteName,
    required String utilRouteName,
    Object? arguments,
  }) {
    Navigator.pushNamedAndRemoveUntil(
      this,
      newRouteName,
      ModalRoute.withName(utilRouteName),
      arguments: arguments,
    );
  }
}
