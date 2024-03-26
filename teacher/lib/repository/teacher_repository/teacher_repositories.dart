import 'package:teacher/model/user_info.dart';

abstract class TeacherRepository {
  Future<void> getListTeacher(UserInfo userInfo);
}

class TeacherRepositoryImpl implements TeacherRepository {
  @override
  Future<void> getListTeacher(UserInfo userInfo) {
    // TODO: implement getListTeacher
    throw UnimplementedError();
  }
}
