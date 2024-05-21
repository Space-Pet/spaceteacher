// import 'package:flutter/material.dart';

// import 'package:teacher/src/screens/home/view/home_screen.dart';
// import 'package:teacher/src/services/routes/router_services.dart';

// final homeNavigatorKey = GlobalKey<NavigatorState>();

// class HomeNavigator extends StatelessWidget {
//   HomeNavigator({super.key});

//   final AppRouter _appRouter = AppRouter();
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.transparent,
//       body: HomeScreen(),

//       // Navigator(
//       //   key: homeNavigatorKey,
//       //   onGenerateRoute: _appRouter.onGeneratePageRouteBuilder,
//       //   onGenerateInitialRoutes: (navigator, initialRoute) {
//       //     return [
//       //       navigator.widget.onGenerateRoute!(
//       //         const RouteSettings(
//       //           name: HomeScreen.routeName,
//       //         ),
//       //       )!,
//       //     ];
//       //   },
//       // ),
//     );
//   }
// }
