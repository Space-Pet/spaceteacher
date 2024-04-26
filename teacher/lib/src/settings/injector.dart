import 'package:core/core.dart';
import 'package:teacher/repository/auth_repository/auth_repositories.dart';
import 'package:teacher/repository/evaluation_repository/evaluation_repositories.dart';
import 'package:teacher/repository/gallery_repository/gallery_repositories.dart';
import 'package:teacher/repository/notification_repository/notification_repositories.dart';
import 'package:teacher/repository/student_repository/student_repository.dart';
import 'package:teacher/repository/user_repository/user_repositories.dart';
import 'package:teacher/src/settings/settings.dart';

class Injector {
  static void init() {
    Injection.put<Settings>(Settings());
    Injection.put<AuthRepository>(AuthRepositoryImp());
    Injection.put<UserRepository>(UserRepositoryImpl());
    Injection.put<StudentRepository>(StudentRepositoryImp());
    Injection.put<EvaluationRepository>(EvaluationRepositoryImp());
    Injection.put<NotificationRepository>(NotificationRepositoryImp());
    Injection.put<GalleryRepository>(GalleryRepositoryImpl());
  }
}
