import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teacher/src/screens/attendance/view/attendance_screen.dart';
import 'package:teacher/src/services/routes/router_services.dart';

final homeNavigatorKey = GlobalKey<NavigatorState>();

class AttendanceNavigator extends StatelessWidget {
  AttendanceNavigator({super.key});
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Navigator(
        key: homeNavigatorKey,
        onGenerateRoute: _appRouter.onGeneratePageRouteBuilder,
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
}
