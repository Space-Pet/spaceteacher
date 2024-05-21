import 'package:core/core.dart';
import 'package:teacher/model/pupil_contact_student_model.dart';
import 'package:teacher/model/student_model.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';

import '../../src/services/network_services/api_client.dart';

abstract class StudentRepository {
  Future<StudentModel?> getInfoStudents({int? pupilId});
  Future<List<PupilContactStudentModel>> getListContactStudent({int? pupilId});
  Future<StudentModel?> updateInfoStudent(
      {int? pupilId, StudentModel? studentModel});
  Future<List<PupilContactStudentModel>> getListStudentFollowClass(
      {int? classId, int? schoolId, String? schoolBrand});
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

  @override
  Future<List<PupilContactStudentModel>> getListContactStudent(
      {int? pupilId}) async {
    try {
      final String accessToken =
          await Injection.get<Settings>().getAccessToken() ?? "";
      final res = await ApiClient(
        '${ApiPath.getListContactStudent}/$pupilId',
        headers: {"Authorization": "Bearer $accessToken"},
      ).get();
      if (isNullOrEmpty(res['data']['pupils'])) {
        return <PupilContactStudentModel>[];
      }
      Log.prettyJson(res['data']['pupils']);
      return res['data']['pupils']
          .map((e) => PupilContactStudentModel.fromJson(e))
          .toList();
    } catch (e) {
      Log.e('$e',
          name:
              "Get List Contact Student Error StudentRepository -> getListContactStudent()");
    }
    return <PupilContactStudentModel>[];
  }

  @override
  Future<StudentModel?> updateInfoStudent(
      {int? pupilId, StudentModel? studentModel}) async {
    try {
      final String accessToken =
          await Injection.get<Settings>().getAccessToken() ?? "";
      final res = await ApiClient(
        '${ApiPath.getInfoStudent}$pupilId',
        headers: {"Authorization": "Bearer $accessToken"},
      ).put({
        "mother_name": studentModel?.parent?.motherName,
        "phone": studentModel?.pupilModel?.phone,
        "father_phone": studentModel?.parent?.fatherPhone,
      });
      if (isNullOrEmpty(res['data'])) return null;
      Log.prettyJson(res['data']);
      return StudentModel.fromJson(res['data']);
    } catch (e) {
      Log.e('$e',
          name:
              "Update Info Student Error StudentRepository -> updateInfoStudent()");
    }

    return StudentModel();
  }

  @override
  Future<List<PupilContactStudentModel>> getListStudentFollowClass(
      {int? classId, int? schoolId, String? schoolBrand}) async {
    try {
      final String accessToken =
          await Injection.get<Settings>().getAccessToken() ?? "";
      final res = await ApiClient(
        '${ApiPath.getListStudentFollowClass}/$classId/pupils',
        headers: {
          "Authorization": "Bearer $accessToken",
          "School-Id": "$schoolId",
          "School-Brand": "$schoolBrand"
        },
      ).get();
      if (isNullOrEmpty(res['data'])) {
        return <PupilContactStudentModel>[];
      }
      Log.prettyJson(res['data']);
      return res['data']
          .map((e) => PupilContactStudentModel.fromJson(e))
          .toList();
    } catch (e) {
      Log.e('$e',
          name:
              "Get List Student Follow Class Error StudentRepository -> getListStudentFollowClass()");
    }
    return <PupilContactStudentModel>[];
  }
}
