import 'package:flutter/foundation.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:network_data_source/src/score_api/score_api.dart';

class FetchScoreFailure implements Exception {}

class GetJobListFailure implements Exception {}

class LogOutFailure implements Exception {}

class GetCellStockFailure implements Exception {}

class NoteFailure implements Exception {}

class SettingFailure implements Exception {}

class ScoreAPI extends AbstractScoreAPI {
  ScoreAPI({required AbstractDioClient client}) : _client = client;

  final AbstractDioClient _client;

  Future<ScoreData> fetchScore({
    required String act,
    required String userKey,
    required String txtHocKy,
    required String txtTextYear,
  }) async {
    try {
      final data = await _client.doHttpPost(
        url: 'api.php',
        requestBody: {
          "act": act,
          "user_key": userKey,
          "txt_hoc_ky": txtHocKy,
          "txt_learn_year": txtTextYear
        },
      );
      final dataScore = data;
      final scoreInfo = ScoreData.fromMap(dataScore);

      return scoreInfo;
    } catch (e) {
      debugPrint('error Score fetch: $e');
      throw FetchScoreFailure();
    }
  }
}
