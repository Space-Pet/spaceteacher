import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/screens/exercise_notice/exercise_screen.dart';
import 'package:iportal2/screens/home/home_screen.dart';
import 'package:iportal2/screens/schedule/schedule_screen.dart';
import 'package:iportal2/screens/student_score/student_score_screen_main.dart';

final homeNavigatorKey = GlobalKey<NavigatorState>();

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Navigator(
        key: homeNavigatorKey,
        initialRoute: HomeScreen.routeName,
        onGenerateRoute: _onGenerateRoute,
        onGenerateInitialRoutes: (navigator, initialRoute) {
          return [
            navigator.widget.onGenerateRoute!(
              const RouteSettings(
                name: HomeScreen.routeName,
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
      case HomeScreen.routeName:
        page = const HomeScreen();
        break;

      case ScheduleScreen.routeName:
        page = const ScheduleScreen();
        break;
      case StudentScoreScreenMain.routeName:
        page = const StudentScoreScreenMain();
        break;
      case ExerciseScreen.routeName:
        page = const ExerciseScreen();
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
