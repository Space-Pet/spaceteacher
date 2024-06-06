import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/screens/attendance/view/attendance_screen.dart';

final attendanceNavigatorKey = GlobalKey<NavigatorState>();

class AttendanceNavigator extends StatelessWidget {
  const AttendanceNavigator({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Navigator(
        key: attendanceNavigatorKey,
        initialRoute: AttendanceScreen.routeName,
        onGenerateRoute: _onGenerateRoute,
        onGenerateInitialRoutes: (navigator, initialRoute) {
          return [
            navigator.widget.onGenerateRoute!(
              const RouteSettings(
                name: AttendanceScreen.routeName,
              ),
            )!,
          ];
        },
      ),
    );
  }

  PageRouteBuilder<dynamic>? _onGenerateRoute(RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      case AttendanceScreen.routeName:
        page = const AttendanceScreen();
        break;

      default:
        return CustomRouter.onGenerateRoute(settings);
    }

    return CustomRouter.transitionAnimation(
      child: page,
      routeName: settings.name ?? '',
    );
  }
}
