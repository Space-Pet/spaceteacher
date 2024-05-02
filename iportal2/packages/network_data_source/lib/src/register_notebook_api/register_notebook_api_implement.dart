import 'package:core/data/models/models.dart';
import 'package:network_data_source/network_data_source.dart';

class GetRegisterNoteBookFailure implements Exception {}

class GetExerciseFailure implements Exception {}

class GetScoreFailure implements Exception {}

class RegisterNoteBookApi extends AbstractRegisterNotebookApi {
  RegisterNoteBookApi({
    required AbstractDioClient client,
    required RestApiClient authRestClient,
    required RestApiClient partnerTokenRestClient,
  })  : _client = client,
        _authRestClient = authRestClient,
        _partnerTokenRestClient = partnerTokenRestClient;

  final AbstractDioClient _client;
  final RestApiClient _authRestClient;
  final RestApiClient _partnerTokenRestClient;

  Future<WeeklyLessonData> getRegisterNoteBook() async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
          '/api.php?act=weeklylesson&type=json&user_key=0563180077&txt_date=15-03-2024');

      final weeklylessonData = WeeklyLessonData.fromMap(data);
      return weeklylessonData;
    } catch (e) {
      throw GetRegisterNoteBookFailure();
    }
  }

  Future<ExerciseData> getExercise(String userKey, String txtDate) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
          '/api.php?act=booktable_new&user_key=$userKey&txt_date=$txtDate');

      final exerciseData = ExerciseData.fromMap(data);
      return exerciseData;
    } catch (e) {
      throw GetExerciseFailure();
    }
  }

  Future<ScoreModel> getScore(
      String userKey, String txtTerm, String txtYear) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
          '/api.php?act=show_score&user_key=$userKey&txt_hoc_ky=$txtTerm&txt_learn_year=$txtYear');
      final scoreRes = ScoreModel.fromMap(data);

      return scoreRes;
    } catch (e) {
      throw GetScoreFailure();
    }
  }
}
