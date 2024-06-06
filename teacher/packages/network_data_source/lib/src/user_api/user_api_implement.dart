import 'package:core/core.dart';

import '../../network_data_source.dart';

class UserApi extends AbstractUserApi {
  UserApi({
    required AbstractDioClient client,
    required RestApiClient authRestClient,
    required RestApiClient partnerTokenRestClient,
  })  : _client = client,
        _authRestClient = authRestClient,
        _partnerTokenRestClient = partnerTokenRestClient;

  final AbstractDioClient _client;
  final RestApiClient _authRestClient;
  final RestApiClient _partnerTokenRestClient;

  Future<TeacherDetail> getTeacherDetail(String teacherId) async {
    try {
      final data = await _client.doHttpGet('/api/v1/staff/teacher/$teacherId');
      final teacherDetail = TeacherDetail.fromMap(data['data']);
      return teacherDetail;
    } catch (e) {
      throw GetTeacherInfoFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await _client.clearToken();
      _partnerTokenRestClient.clearDomain();
      _authRestClient.clearDomain();
    } catch (_) {}
  }
}

class GetTeacherInfoFailure implements Exception {}
