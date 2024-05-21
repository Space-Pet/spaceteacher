import 'package:flutter/material.dart';
import 'package:teacher/app_main_layout.dart';
import 'package:teacher/model/gallery_model.dart';
import 'package:teacher/model/menu.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/src/screens/attendance/view/attendance_screen.dart';
import 'package:teacher/src/screens/attendance_qr/attendance_qr_screen.dart';
import 'package:teacher/src/screens/authentication/login/view/login_screen.dart';
import 'package:teacher/src/screens/bus/bus_screen.dart';
import 'package:teacher/src/screens/gallery/gallery_screen.dart';
import 'package:teacher/src/screens/gallery/widget/gallery_detail/gallery_detail.dart';
import 'package:teacher/src/screens/gallery/widget/gallery_detail/gallery_view_carousel.dart';
import 'package:teacher/src/screens/home/view/home_screen.dart';
import 'package:teacher/src/screens/leave/history_leave_screen.dart';
import 'package:teacher/src/screens/leave/on_leave_screen.dart';
import 'package:teacher/src/screens/menu/detail_menu_screen.dart';
import 'package:teacher/src/screens/menu/menu_screen.dart';
import 'package:teacher/src/screens/notifications/view/notifications_screen.dart';
import 'package:teacher/src/screens/observation_schedule/mock_data/subject_mock.dart';
import 'package:teacher/src/screens/observation_schedule/screen/create_observation/create_observation_screen.dart';
import 'package:teacher/src/screens/observation_schedule/screen/hourly_assessment/hourly_assessment_screen.dart';
import 'package:teacher/src/screens/observation_schedule/screen/hourly_assessment/hourly_assessment_submit_screen.dart';
import 'package:teacher/src/screens/observation_schedule/screen/observation_detail/overvation_detail_screen.dart';
import 'package:teacher/src/screens/observation_schedule/screen/observation_schedule_screen.dart';
import 'package:teacher/src/screens/observation_schedule/widgets/filter_observation.dart';

import 'package:teacher/src/screens/profile/view/profile_screen.dart';
import 'package:teacher/src/screens/schedule/schedule_screen.dart';
import 'package:teacher/src/screens/setting/view/setting_screen.dart';
import 'package:teacher/src/screens/survey/survey_screen.dart';
import 'package:teacher/src/splash/curved_splash_screen.dart';

import 'package:teacher/src/splash/loading_screen.dart';

import '../../screens/phone_book/phone_book_screen.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return _getPage(LoginScreen());
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
      case ObservationSchedule.routeName:
        return _getPage(
          const ObservationSchedule(),
        );
      case SurveyScreen.routeName:
        return _getPage(const SurveyScreen());
      case BusScreen.routeName:
        return _getPage(
          const BusScreen(),
        );
      case MenuScreen.routeName:
        final args = settings.arguments as Map?;
        UserInfo? userInfo;
        if (args != null) {
          userInfo = args['userInfo'];
        }
        return _getPage(
          MenuScreen(
            userInfo: userInfo ?? UserInfo(),
          ),
          fullscreenDialog: false,
          maintainState: true,
        );
      case OnLeaveScreen.routeName:
        final args = settings.arguments as Map?;
        UserInfo? userInfo;
        if (args != null) {
          userInfo = args['userInfo'];
        }
        return _getPage(
          OnLeaveScreen(
            userInfo: userInfo ?? UserInfo(),
          ),
          fullscreenDialog: false,
          maintainState: true,
        );
      case HistoryLeaveScreen.routeName:
        final args = settings.arguments as Map?;
        UserInfo? userInfo;
        if (args != null) {
          userInfo = args['userInfo'];
        }
        return _getPage(
          HistoryLeaveScreen(
            userInfo: userInfo ?? UserInfo(),
          ),
          fullscreenDialog: false,
          maintainState: true,
        );
      case FilterObservation.routeName:
        return _getPage(
          const FilterObservation(),
        );
      case ObservationDetailScreen.routeName:
        final args = settings.arguments as Map?;
        MockSubjectData? data;
        int? typeObservation;
        if (args != null) {
          data = args['data'];
          typeObservation = args['typeObservation'];
        }
        return _getPage(
          ObservationDetailScreen(
            data: data ?? MockSubjectData(),
            typeObservation: typeObservation ?? 0,
          ),
        );
      case HourAssessmentScreen.routeName:
        return _getPage(
          const HourAssessmentScreen(),
        );
      case HourAssessmentSubmitScreen.routeName:
        final args = settings.arguments as Map?;
        double? valuePercent;
        String? name;
        String? subject;
        String? classRoom;
        double? valuePercentPrepareLessons;
        double? valuePercentSpeak;
        double? valuePercentGroupDiscussion;
        String? evaluation;
        String? teacher;
        String? date;
        if (args != null) {
          valuePercent = args['valuePercent'];
          name = args['name'];
          subject = args['subject'];
          classRoom = args['classRoom'];
          valuePercentPrepareLessons = args['valuePercentPrepareLessons'];
          valuePercentSpeak = args['valuePercentSpeak'];
          valuePercentGroupDiscussion = args['valuePercentGroupDiscussion'];
          evaluation = args['evaluation'];
          teacher = args['teacher'];
          date = args['date'];
        }
        return _getPage(
          HourAssessmentSubmitScreen(
            valuePercent: valuePercent ?? 0,
            name: name ?? "",
            subject: subject ?? "",
            classRoom: classRoom ?? "",
            valuePercentPrepareLessons: valuePercentPrepareLessons ?? 0,
            valuePercentSpeak: valuePercentSpeak ?? 0,
            valuePercentGroupDiscussion: valuePercentGroupDiscussion ?? 0,
            evaluation: evaluation ?? "",
            teacher: teacher ?? "",
            date: date ?? "",
          ),
        );

      case CreateObservationScreen.routeName:
        return _getPage(
          const CreateObservationScreen(),
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
    bool? fullscreenDialog,
    bool? maintainState,
  }) {
    return PageRouteBuilder(
      fullscreenDialog: fullscreenDialog ?? false,
      maintainState: maintainState ?? true,
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
      case AttendanceQRScreen.routeName:
        return transitionAnimation(
            child: const AttendanceQRScreen(),
            routeName: AttendanceQRScreen.routeName);
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
          child: AttendanceScreen(),
        );
      case NotificationsScreen.routeName:
        return transitionAnimation(
          routeName: NotificationsScreen.routeName,
          child: const NotificationsScreen(),
        );

      case MenuScreen.routeName:
        final args = settings.arguments as Map?;
        UserInfo? userInfo;
        if (args != null) {
          userInfo = args['userInfo'];
        }
        return transitionAnimation(
          routeName: MenuScreen.routeName,
          child: MenuScreen(
            userInfo: userInfo ?? UserInfo(),
          ),
        );

      case OnLeaveScreen.routeName:
        final args = settings.arguments as Map?;
        UserInfo? userInfo;
        if (args != null) {
          userInfo = args['userInfo'];
        }
        return transitionAnimation(
          routeName: OnLeaveScreen.routeName,
          child: OnLeaveScreen(
            userInfo: userInfo ?? UserInfo(),
          ),
        );
      case HistoryLeaveScreen.routeName:
        final args = settings.arguments as Map?;
        UserInfo? userInfo;
        if (args != null) {
          userInfo = args['userInfo'];
        }
        return transitionAnimation(
          routeName: HistoryLeaveScreen.routeName,
          child: HistoryLeaveScreen(
            userInfo: userInfo ?? UserInfo(),
          ),
        );
      case GalleryDetail.routeName:
        final args = settings.arguments as Map?;
        GalleryModel? galleryItem;
        if (args != null) {
          galleryItem = args['galleryItem'];
        }
        return transitionAnimation(
          routeName: GalleryDetail.routeName,
          child: GalleryDetail(
            galleryItem: galleryItem ?? GalleryModel(),
          ),
        );
      case GalleryScreen.routeName:
        final args = settings.arguments as Map?;
        int? teacherId;
        if (args != null) {
          teacherId = args['teacherId'];
        }
        return transitionAnimation(
          routeName: GalleryScreen.routeName,
          child: GalleryScreen(
            teacherId: teacherId ?? 0,
          ),
        );

      case SurveyScreen.routeName:
        return transitionAnimation(
            child: SurveyScreen(), routeName: SurveyScreen.routeName);

      case PhoneBookScreen.routeName:
        return transitionAnimation(
            routeName: PhoneBookScreen.routeName,
            child: const PhoneBookScreen());

      case GalleryCarousel.routeName:
        final args = settings.arguments as Map?;
        GalleryModel? galleryItem;
        int? index;
        if (args != null) {
          galleryItem = args['galleryItem'];
          index = args['index'];
        }
        return transitionAnimation(
          routeName: GalleryCarousel.routeName,
          child: GalleryCarousel(
            galleryItem: galleryItem ?? GalleryModel(),
            index: index ?? 0,
          ),
        );

      case BusScreen.routeName:
        return transitionAnimation(
          routeName: BusScreen.routeName,
          child: const BusScreen(),
        );
      case ObservationSchedule.routeName:
        return transitionAnimation(
          fullscreenDialog: true,
          routeName: ObservationSchedule.routeName,
          child: const ObservationSchedule(),
        );

      default:
        assert(false, 'Need to implement ${settings.name}');
        return null;
    }
  }
}
