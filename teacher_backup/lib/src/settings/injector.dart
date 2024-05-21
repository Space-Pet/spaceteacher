import 'package:core/core.dart';
import 'package:core/presentation/screens/domain/domain_saver.dart';
import 'package:teacher/repository/auth_repository/auth_repositories.dart';
import 'package:teacher/repository/bus_repository/bus_repositories.dart';
import 'package:teacher/repository/evaluation_repository/evaluation_repositories.dart';
import 'package:teacher/repository/gallery_repository/gallery_repositories.dart';
import 'package:teacher/repository/leave_repository/leave_repository.dart';
import 'package:teacher/repository/menu_repository/menu_repositories.dart';
import 'package:teacher/repository/notification_repository/notification_repositories.dart';
import 'package:teacher/repository/student_repository/student_repository.dart';
import 'package:teacher/repository/survey_repositories/survey_repositories.dart';
import 'package:teacher/repository/user_repository/user_repositories.dart';
import 'package:teacher/src/settings/settings.dart';

class Injector {
  static void init() {
    Injection.put<DomainSaver>(DomainSaver());
    Injection.put<Settings>(Settings());
    Injection.put<AuthRepository>(AuthRepositoryImp());
    Injection.put<UserRepository>(UserRepositoryImpl());
    Injection.put<StudentRepository>(StudentRepositoryImp());
    Injection.put<EvaluationRepository>(EvaluationRepositoryImp());
    Injection.put<NotificationRepository>(NotificationRepositoryImp());
    Injection.put<GalleryRepository>(GalleryRepositoryImpl());
    Injection.put<SurveyRepository>(SurveyRepositoryImpl());
    Injection.put<BusRepository>(BusRepositoryImpl());
    Injection.put<MenuRepository>(MenuRepositoryImpl());
    Injection.put<LeaveRepository>(LeaveRepositoryImpl());
  }
}
