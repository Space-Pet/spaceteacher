import 'package:core/presentation/screens/domain/domain_screen.dart';
import 'package:flutter/material.dart';
import 'package:teacher/screens/authentication/domain/view/login_screen.dart';
import 'package:teacher/screens/bus/bus_screen.dart';
import 'package:teacher/screens/exercise_notice/exercise_screen.dart';
import 'package:teacher/screens/fee_plan/fee_plan_screen.dart';
import 'package:teacher/screens/gallery/gallery_screen.dart';
import 'package:teacher/screens/gallery/widget/gallery_create/gallery_create.dart';
import 'package:teacher/screens/home/home_screen.dart';
import 'package:teacher/screens/leave/on_leave_screen.dart';
import 'package:teacher/screens/menu/menu_screen.dart';
import 'package:teacher/screens/notifications/create/noti_create_screen.dart';
import 'package:teacher/screens/notifications/detail/notification_detail_screen.dart';
import 'package:teacher/screens/nutrition_heath/nutrition_screen.dart';
import 'package:teacher/screens/phone_book/phone_book_screen.dart';
import 'package:teacher/screens/pre_score/preS_score_screen.dart';
import 'package:teacher/screens/register_notebook/register_notebook_screen.dart';
import 'package:teacher/screens/score/edit_score_screen.dart';
import 'package:teacher/screens/score/views/class_score/class_score_screen.dart';
import 'package:teacher/screens/splash/loading_screen.dart';
import 'package:teacher/screens/survey/survey_screen.dart';

class CustomRouter {
  static PageRouteBuilder transitionAnimation({
    required Widget child,
    required String routeName,
  }) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      transitionDuration: const Duration(milliseconds: 150),
      pageBuilder: (c, a1, a2) => child,
      transitionsBuilder: (c, anim, a2, child) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(anim),
        child: child,
      ),
    );
  }

  static PageRouteBuilder<dynamic>? onGenerateRoute(RouteSettings? settings) {
    switch (settings!.name) {
      case CDomainScreen.routeName:
        return transitionAnimation(
            child: const LoginScreen(), routeName: CDomainScreen.routeName);

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

      case ExerciseScreen.routeName:
        return transitionAnimation(
          routeName: ExerciseScreen.routeName,
          child: const ExerciseScreen(),
        );

      case BusScreen.routeName:
        return transitionAnimation(
            child: const BusScreen(), routeName: BusScreen.routeName);

      case FeePlanScreen.routeName:
        return transitionAnimation(
            child: const FeePlanScreen(), routeName: FeePlanScreen.routeName);

      case MenuScreen.routeName:
        return transitionAnimation(
            child: const MenuScreen(), routeName: MenuScreen.routeName);

      case GalleryScreen.routeName:
        return transitionAnimation(
            child: const GalleryScreen(), routeName: GalleryScreen.routeName);

      case GalleryCreateNew.routeName:
        return transitionAnimation(
            child: const GalleryCreateNew(),
            routeName: GalleryCreateNew.routeName);

      case NutritionScreen.routeName:
        return transitionAnimation(
            child: const NutritionScreen(),
            routeName: NutritionScreen.routeName);

      case EditScoreScreen.routeName:
        return transitionAnimation(
          child: const EditScoreScreen(),
          routeName: EditScoreScreen.routeName,
        );

      case PreScoreScreen.routeName:
        return transitionAnimation(
          child: const PreScoreScreen(),
          routeName: PreScoreScreen.routeName,
        );

      case NotiDetailScreen.routeName:
        return transitionAnimation(
          child: const NotiDetailScreen(id: 0),
          routeName: NotiDetailScreen.routeName,
        );

      case NotiCreateNew.routeName:
        return transitionAnimation(
          child: const NotiCreateNew(),
          routeName: NotiCreateNew.routeName,
        );

      case SurveyScreen.routeName:
        return transitionAnimation(
          child: const SurveyScreen(),
          routeName: SurveyScreen.routeName,
        );

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
