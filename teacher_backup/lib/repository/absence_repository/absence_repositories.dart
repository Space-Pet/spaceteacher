import 'package:core/core.dart';
import 'package:teacher/model/history_absence_model.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';
import '../../src/services/network_services/api_client.dart';

abstract class AbsenceRepository {
  Future<HistoryAbsenceModel> getHistoryAbsenceStudent(
      {String? classId,
      String? pupilId,
      String? schoolId,
      String? schoolBrand});
}

class AbsenceRepositoryImpl implements AbsenceRepository {
  @override
  Future<HistoryAbsenceModel> getHistoryAbsenceStudent(
      {String? classId,
      String? pupilId,
      String? schoolId,
      String? schoolBrand}) async {
    try {
      final accessToken = Injection.get<Settings>().getAccessToken();

      final res = await ApiClient(
        '${ApiPath.getHistoryAbsenceStudent}?class_id=$classId&pupil_id=$pupilId',
        headers: {
          'Authorization': 'Bearer $accessToken',
          'School-Id': schoolId,
          'School-Brand': schoolBrand,
        },
      ).get();

      if (isNullOrEmpty(res['data'])) return HistoryAbsenceModel();

      return HistoryAbsenceModel.fromJson(res['data']);
    } catch (e) {
      Log.e(
        '$e',
        name:
            'Get History Absence Error AbsenceRepository -> getHistoryAbsenceStudent()',
      );
    }
    return HistoryAbsenceModel();
  }
}
