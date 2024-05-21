import 'package:core/core.dart';
import 'package:core/data/models/survay_data.dart';
import 'package:teacher/src/services/network_services/api_client.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';

abstract class SurveyRepository {
  Future<List<SurveyData>> getSurvey();
}

class SurveyRepositoryImpl implements SurveyRepository {
  @override
  Future<List<SurveyData>> getSurvey() async {
    try {
      final String accessToken =
          await Injection.get<Settings>().getAccessToken() ?? "";
      final res = await ApiClient(
        ApiPath.getSurvey, headers: {"Authorization": "Bearer $accessToken"},
        // ,preFix: 'api', surfix: '.api.php'
      ).get();
      final List<dynamic> data = res['data'];
      return data.map((json) => SurveyData.fromJson(json)).toList();
    } catch (e) {
      Log.e('$e', name: 'Get Survey Error -> getSurvey()');
      return [];
    }
  }
}
