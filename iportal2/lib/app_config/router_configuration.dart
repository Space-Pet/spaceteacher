import 'package:core/data/models/models.dart';
import 'package:core/presentation/screens/domain/domain_screen.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/authentication/domain/domain_screen.dart';
import 'package:iportal2/screens/bus/bus_screen.dart';
import 'package:iportal2/screens/exercise_notice/exercise_screen.dart';
import 'package:iportal2/screens/fee_plan/fee_plan_screen.dart';
import 'package:iportal2/screens/gallery/gallery_screen.dart';
import 'package:iportal2/screens/home/home_screen.dart';
import 'package:iportal2/screens/leave/leave_application_screen.dart';
import 'package:iportal2/screens/leave/on_leave_screen.dart';
import 'package:iportal2/screens/authentication/login/view/login_screen.dart';
import 'package:iportal2/screens/menu/menu_screen.dart';
import 'package:iportal2/screens/message/chat_room.dart';
import 'package:iportal2/screens/message/list_new_messages.dart';
import 'package:iportal2/screens/message/message_screen.dart';
import 'package:iportal2/screens/notifications/detail/notification_detail_screen.dart';
import 'package:iportal2/screens/nutrition_heath/nutrition_screen.dart';
import 'package:iportal2/screens/phone_book/phone_book_screen.dart';
import 'package:iportal2/screens/pre_score/preS_score_screen.dart';
import 'package:iportal2/screens/register_notebook/register_notebook_screen.dart';
import 'package:iportal2/screens/school_fee/screen/school_fee_screen.dart';
import 'package:iportal2/screens/score/score_screen.dart';
import 'package:iportal2/screens/splash/loading_screen.dart';

class CustomRouter {
  static PageRouteBuilder transitionAnimation({
    required Widget child,
    required String routeName,
    Object? arguments,
  }) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName, arguments: arguments),
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
            child: const DomainScreen(), routeName: CDomainScreen.routeName);
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

      case ChatRoomScreen.routeName:
        final arguments = settings.arguments as Map<String, dynamic>;
        final message = arguments['message'] as Message;
        final phoneBookStudent =
            arguments['phoneBookStudent'] as PhoneBookStudent;
        return transitionAnimation(
          child: ChatRoomScreen(
            messageChatRoom: message,
            phoneBookStudent: phoneBookStudent,
          ),
          routeName: ChatRoomScreen.routeName,
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

      case MessageScreen.routeName:
        return transitionAnimation(
          child: const MessageScreen(),
          routeName: MessageScreen.routeName,
        );

      case ListNewMessagesScreen.routeName:
        return transitionAnimation(
          child: const ListNewMessagesScreen(),
          routeName: ListNewMessagesScreen.routeName,
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

      case FeePlanScreen.routeName:
        return transitionAnimation(
            child: const FeePlanScreen(), routeName: FeePlanScreen.routeName);

      case MenuScreen.routeName:
        return transitionAnimation(
            child: const MenuScreen(), routeName: MenuScreen.routeName);

      case GalleryScreen.routeName:
        return transitionAnimation(
            child: const GalleryScreen(), routeName: GalleryScreen.routeName);

      case NutritionScreen.routeName:
        return transitionAnimation(
            child: const NutritionScreen(),
            routeName: NutritionScreen.routeName);

      case ScoreScreen.routeName:
        return transitionAnimation(
          child: const ScoreScreen(),
          routeName: ScoreScreen.routeName,
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

      case SchoolFeeScreen.routeName:
        return transitionAnimation(
          child: const SchoolFeeScreen(),
          routeName: SchoolFeeScreen.routeName,
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

  popUntil({required bool Function(Route<dynamic>) predicate}) {
    Navigator.popUntil(this, predicate);
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
