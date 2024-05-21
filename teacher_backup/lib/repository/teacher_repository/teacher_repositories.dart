import 'package:core/core.dart';

import 'package:teacher/model/student_result_model.dart';
import 'package:teacher/model/teacher_info_model.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';

import '../../src/services/network_services/api_client.dart';

abstract class TeacherRepository {
  Future<List<TeacherInfo>> getListTeacher(int? pupilID);

  Future<List<StudentResultModel>?> getResultStudent(
      {UserInfo? userInfo, int? evaluationFormId});
}

class TeacherRepositoryImpl implements TeacherRepository {
  @override
  Future<List<TeacherInfo>> getListTeacher(int? pupilID) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();
      final res = await ApiClient('${ApiPath.getListTeacher}?pupil_id=$pupilID',
          headers: {'Authorization': 'Bearer $accessToken'}).get();

      if (isNullOrEmpty(res['data']['items'])) return <TeacherInfo>[];

      return res['data']['items']
          .map<TeacherInfo>((e) => TeacherInfo.fromJson(e))
          .toList();
    } catch (e) {
      Log.e('$e',
          name:
              'Get List Teacher Error EvaluationRepository -> getListTeacher()');
    }
    return <TeacherInfo>[];
  }

  @override
  Future<List<StudentResultModel>?> getResultStudent(
      {UserInfo? userInfo, int? evaluationFormId}) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();
      final res = await ApiClient(
          '${ApiPath.getEvaluationFormFollowStudent}?id=$evaluationFormId&pupil_id=${userInfo?.pupilId}',
          headers: {
            'Authorization': 'Bearer $accessToken',
            'School-Id': '${userInfo?.schoolId}',
            'School-Brand': '${userInfo?.schoolBrand}'
          }).get();

      if (isNullOrEmpty(res['data']['items'])) return <StudentResultModel>[];

      return res['data']['items']
          .map<StudentResultModel>((e) => StudentResultModel.fromJson(e))
          .toList();
    } catch (e) {
      Log.e('$e',
          name:
              'Get Result Student Error EvaluationRepository -> getResultStudent()');
    }
    return <StudentResultModel>[];
  }
}
