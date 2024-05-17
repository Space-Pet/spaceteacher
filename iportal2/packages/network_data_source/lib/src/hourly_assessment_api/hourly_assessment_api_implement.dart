import 'package:core/data/models/models.dart';
import 'package:network_data_source/network_client/abtract_dio_client.dart';
import 'package:network_data_source/src/hourly_assessment_api/abstract_hourly_assessment_api.dart';

class HourlyAssessmentApi implements AbstractHourlyAssessmentApi {
  HourlyAssessmentApi({
    required AbstractDioClient client,
    required RestApiClient authRestClient,
    required RestApiClient partnerTokenRestClient,
  })  : _client = client,
        _authRestClient = authRestClient,
        _partnerTokenRestClient = partnerTokenRestClient;

  final AbstractDioClient _client;
  final RestApiClient _authRestClient;
  final RestApiClient _partnerTokenRestClient;
  @override
  Future<RegisterHourlyAssessment> createHourlyAssessment(
      {required String userKey,
      required int teacherId,
      required int classId,
      required int subjectId,
      required int schoolId,
      required String date,
      required int tietNum}) async {
    final data = await _partnerTokenRestClient.doHttpPost(
      url: 'api/api.php',
      queryParameters: {
        'act': 'post_lesson_register_note',
      },
      requestBody: {
        'user_key': userKey,
        'teacher_id': teacherId,
        'class_id': classId,
        'subject_id': subjectId,
        'school_id': schoolId,
        'date': date,
        'tiet_num': tietNum,
      },
    );
    return RegisterHourlyAssessment.fromJson(data);
  }

  @override
  Future<StatusHourlyAssessment> deleteHourlyAssessment(
      {required String userKey, required int lessonRegisterId}) async {
    final data = await _partnerTokenRestClient.doHttpDelete(
      url: 'api/api.php',
      queryParameters: {
        'act': 'delete_lesson_register',
      },
      requestBody: {
        'user_key': userKey,
        'lesson_register_id': lessonRegisterId,
      },
    );
    return StatusHourlyAssessment.fromJson(data);
  }

  @override
  Future<void> getEvaluateEnglishHourlyAssessment(
      {required String userKey, required int lessonRegisterId}) {
    // TODO: implement getEvaluateMOETHourlyAssessment
    throw UnimplementedError();
  }

  @override
  Future<void> getEvaluateMOETHourlyAssessment(
      {required String userKey, required int lessonRegisterId}) {
    // TODO: implement getEvaluateMOETHourlyAssessment
    throw UnimplementedError();
  }

  @override
  Future<List<HourlyAssessmentDetail>> getListHourlyAssessmentDetail(
      {required String userKey,
      required int schoolId,
      required String date,
      required int teacherId}) async {
    final data = await _partnerTokenRestClient.doHttpGet(
      'api/api.php',
      queryParameters: {
        'act': 'get_lesson_register',
        'user_key': userKey,
        'school_id': schoolId,
        'date': date,
        'teacher_id': teacherId,
      },
    );
    return (data as List)
        .map((e) => HourlyAssessmentDetail.fromJson(e))
        .toList();
  }

  @override
  Future<HourlyAssessment> getObservationSchedule(
      {required String userKey,
      required int classId,
      required String dateFrom,
      required String dateTo}) async {
    final data = await _partnerTokenRestClient.doHttpGet(
      'api/api.php',
      queryParameters: {
        'act': 'get_lesson_register',
        'user_key': userKey,
        'class_id': classId,
        'date_from': dateFrom,
        'date_to': dateTo,
      },
    );
    return HourlyAssessment.fromJson(data);
  }

  @override
  Future<UpdateHourlyAssessment> updateHourlyAssessment(
      {required String userKey,
      required int lessonRegisterId,
      required String noteId,
      required int diemDat,
      required int tieuChiDiem,
      required String nhanXet}) async {
    final data = await _partnerTokenRestClient.doHttpPost(
      url: 'api/api.php',
      queryParameters: {
        'act': 'post_lesson_register_note',
      },
      requestBody: {
        'user_key': userKey,
        'lesson_register_id': lessonRegisterId,
        'note_id': noteId,
        'diem_dat': diemDat,
        'tieu_chi_diem': tieuChiDiem,
        'nhan_xet': nhanXet,
      },
    );
    return UpdateHourlyAssessment.fromJson(data);
  }
}
