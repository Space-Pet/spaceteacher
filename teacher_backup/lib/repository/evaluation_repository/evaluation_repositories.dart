import 'package:core/core.dart';
import 'package:teacher/model/evaluation_form_model.dart';

import 'package:teacher/model/student_model.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';
import '../../src/services/network_services/api_client.dart';

abstract class EvaluationRepository {
  Future<EvaluationFormModel> getEvaluationForm(
      {UserInfo? userInfo, StudentModel? studentModel});
}

class EvaluationRepositoryImp implements EvaluationRepository {
  @override
  Future<EvaluationFormModel> getEvaluationForm(
      {UserInfo? userInfo, StudentModel? studentModel}) async {
    try {
      final String accessToken =
          await Injection.get<Settings>().getAccessToken() ?? "";
      final res = await ApiClient(
        '${ApiPath.getEvaluationForm}?pupil_id=${studentModel?.pupilModel?.pupilID}&learn_year=${studentModel?.pupilModel?.learnYear}',
        headers: {
          "Authorization": "Bearer $accessToken",
          "School-Id": "${studentModel?.school?.schoolID}",
          "School-Brand": "${userInfo?.schoolBrand}"
        },
      ).get();

      if (isNullOrEmpty(res['data'])) return EvaluationFormModel();

      return EvaluationFormModel.fromJson(res['data']);
    } catch (e) {
      Log.e('$e',
          name:
              "Get Result Student Error EvaluationRepository -> getResultStudent()");
    }

    return EvaluationFormModel();
  }
}
