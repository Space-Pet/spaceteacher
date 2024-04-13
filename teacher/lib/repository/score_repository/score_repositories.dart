import 'package:core/core.dart';
import 'package:teacher/model/high_school_score_model.dart';
import 'package:teacher/model/primary_school_score_model.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';

abstract class ScoreRepository {
  Future<HighSchoolScoreModel> getHighSchoolScore(
      {String? userKey, String? hocKy, String? learnYear});

  Future<PrimarySchoolScoreModel> getPrimarySchoolScore(
      {String? userKey, String? hocKy});
}

class ScoreRepositoryImpl implements ScoreRepository {
  @override
  Future<HighSchoolScoreModel> getHighSchoolScore(
      {String? userKey, String? hocKy, String? learnYear}) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();

      final res = await ApiClient(
        '${ApiPath.getHighSchoolScore}?act=show_score&user_key=$userKey&txt_hoc_ky=$hocKy&txt_learn_year=$learnYear',
        headers: {
          'Parter-Token': 'Bearer $accessToken',
        },
      ).get();

      if (isNullOrEmpty(res)) return HighSchoolScoreModel();

      return HighSchoolScoreModel.fromJson(res);
    } catch (e) {
      Log.e('$e',
          name: 'Get High School Error ScoreRepository -> getHighSchool()');
    }
    return HighSchoolScoreModel();
  }

  @override
  Future<PrimarySchoolScoreModel> getPrimarySchoolScore(
      {String? userKey, String? hocKy}) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();

      final res = await ApiClient(
        '${ApiPath.getPrimarySchoolScore}?act=show_score&user_key=$userKey&txt_hoc_ky=$hocKy',
        headers: {
          'Parter-Token': 'Bearer $accessToken',
        },
      ).get();

      if (isNullOrEmpty(res)) return PrimarySchoolScoreModel();

      return PrimarySchoolScoreModel.fromJson(res);
    } catch (e) {
      Log.e('$e',
          name:
              'Get Primary School Error ScoreRepository -> getPrimarySchool()');
    }

    return PrimarySchoolScoreModel();
  }
}
