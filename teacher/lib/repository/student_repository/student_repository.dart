import 'package:core/core.dart';
import 'package:teacher/model/student_model.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';

abstract class StudentRepository {
  Future<StudentModel?> getInfoStudents({int? pupilId});
}

class StudentRepositoryImp implements StudentRepository {
  @override
  Future<StudentModel?> getInfoStudents({int? pupilId}) async {
    try {
      final String accessToken =
          await Injection.get<Settings>().getAccessToken() ?? "";
      final res = await ApiClient(
        '${ApiPath.getInfoStudent}$pupilId',
        headers: {"Authorization": "Bearer $accessToken"},
      ).get();
      if (isNullOrEmpty(res['data'])) return null;
      Log.prettyJson(res['data']);
      return StudentModel.fromJson(res['data']);
    } catch (e) {
      Log.e('$e',
          name:
              "Get Info Student Error StudentRepository -> getInfoStudents()");
    }

    return StudentModel();
  }
}
