import 'package:flutter/material.dart';
import 'package:teacher/app_main_layout.dart';
import 'package:teacher/model/menu.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/src/screens/attendance/attendance_screen.dart';
import 'package:teacher/src/screens/authentication/login/view/login_screen.dart';
import 'package:teacher/src/screens/home/view/home_screen.dart';
import 'package:teacher/src/screens/menu/detail_menu_screen.dart';
import 'package:teacher/src/screens/menu/menu_screen.dart';
import 'package:teacher/src/screens/notifications/notifications_screen.dart';
import 'package:teacher/src/screens/profile/view/profile_screen.dart';
import 'package:teacher/src/screens/schedule/schedule_screen.dart';
import 'package:teacher/src/screens/setting/view/setting_screen.dart';
import 'package:teacher/src/splash/curved_splash_screen.dart';

import 'package:teacher/src/splash/loading_screen.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return _getPage(const LoginScreen());
      case HomeScreen.routeName:
        return _getPage(const HomeScreen());
      case LoadingScreen.routeName:
        return _getPage(const LoadingScreen());
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
          fullscreenDialog: false,
          maintainState: true,
        );

      case SettingScreen.routeName:
        return _getPage(const SettingScreen(),
            fullscreenDialog: false, maintainState: true);

      case DetailMenuScreen.routeName:
        final args = settings.arguments as Map?;
        Menu? item;
        if (args != null) {
          item = args['item'];
        }
        return _getPage(
          DetailMenuScreen(
            item: item ?? const Menu(),
          ),
          fullscreenDialog: false,
          maintainState: true,
        );

      case CurvedSplashScreen.routeName:
        final args = settings.arguments as Map?;
        int? screensLength;
        Widget Function(int index)? screenBuilder;
        String? nextText;
        String? skipText;

        if (args != null) {
          screensLength = args['screensLength'];
          screenBuilder = args['screenBuilder'];
          nextText = args['nextText'];
          skipText = args['skipText'];
        }
        return _getPage(
          CurvedSplashScreen(
            screensLength: screensLength ?? 0,
            screenBuilder: screenBuilder ?? (index) => const SizedBox(),
            nextText: nextText ?? 'Next',
            skipText: skipText ?? 'Skip',
          ),
        );
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

  PageRouteBuilder transitionAnimation({
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

  PageRouteBuilder<dynamic>? onGeneratePageRouteBuilder(
      RouteSettings? settings) {
    switch (settings!.name) {
      case HomeScreen.routeName:
        return transitionAnimation(
          routeName: HomeScreen.routeName,
          child: const HomeScreen(),
        );

      case ProfileScreen.routeName:
        final args = settings.arguments as Map?;
        UserInfo? userInfo;
        if (args != null) {
          userInfo = args['userInfo'];
        }

        return transitionAnimation(
          routeName: ProfileScreen.routeName,
          child: ProfileScreen(
            userInfo: userInfo ?? UserInfo(),
          ),
        );

      case SettingScreen.routeName:
        return transitionAnimation(
          routeName: SettingScreen.routeName,
          child: const SettingScreen(),
        );

      case ScheduleScreen.routeName:
        return transitionAnimation(
          routeName: ScheduleScreen.routeName,
          child: const ScheduleScreen(),
        );

      case AttendanceScreen.routeName:
        return transitionAnimation(
          routeName: AttendanceScreen.routeName,
          child: const AttendanceScreen(),
        );
      case NotificationsScreen.routeName:
        return transitionAnimation(
          routeName: NotificationsScreen.routeName,
          child: const NotificationsScreen(),
        );

      case MenuScreen.routeName:
        return transitionAnimation(
          routeName: MenuScreen.routeName,
          child: const MenuScreen(),
        );
      case DetailMenuScreen.routeName:
        final args = settings.arguments as Map?;
        Menu? item;
        if (args != null) {
          item = args['item'];
        }
        return transitionAnimation(
          routeName: DetailMenuScreen.routeName,
          child: DetailMenuScreen(
            item: item ?? const Menu(),
          ),
        );

      default:
        assert(false, 'Need to implement ${settings.name}');
        return null;
    }
  }
}
