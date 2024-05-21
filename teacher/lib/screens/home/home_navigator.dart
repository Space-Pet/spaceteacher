import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/screens/home/home_screen.dart';

final homeNavigatorKey = GlobalKey<NavigatorState>();

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
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
    );
  }

  PageRouteBuilder<dynamic>? _onGenerateRoute(RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      case HomeScreen.routeName:
        page = const HomeScreen();
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
