import 'package:core/data/models/models.dart';
import 'package:network_data_source/network_data_source.dart';

class AppFetchApi extends AbstractAppFetchApi {
  AppFetchApi({
    // /api.php? => _partnerTokenRestClient
    // else => _authRestClient
    required AbstractDioClient client,
    required RestApiClient authRestClient,
    required RestApiClient partnerTokenRestClient,
  })  : _client = client,
        _authRestClient = authRestClient,
        _partnerTokenRestClient = partnerTokenRestClient;

  final AbstractDioClient _client;
  final RestApiClient _authRestClient;
  final RestApiClient _partnerTokenRestClient;

  Future<WeeklyLessonData> getRegisterNoteBook({
    required String userKey,
    required String txtDate,
  }) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
          '/api.php?act=weeklylesson&type=json&user_key=$userKey&txt_date=$txtDate');

      final weeklylessonData = WeeklyLessonData.fromMap(data);
      return weeklylessonData;
    } catch (e) {
      throw GetRegisterNoteBookFailure();
    }
  }

  Future<Schedule> getSchedule(
    String userKey,
    String txtDate,
  ) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
          '/api.php?act=timetable_week&user_key=$userKey&txt_date=$txtDate');

      final scheduleData = Schedule.fromMap(data);
      return scheduleData;
    } catch (e) {
      throw GetWeekScheduleFailure();
    }
  }

  Future<ExerciseData> getExercises(
    String userKey,
    String txtDate, {
    bool isDueDate = true,
  }) async {
    final act = isDueDate ? 'booktable_cometime' : 'booktable_new';

    try {
      final data = await _partnerTokenRestClient
          .doHttpGet('/api.php?act=$act&user_key=$userKey&txt_date=$txtDate');

      final exerciseData = ExerciseData.fromMap(data);
      return exerciseData;
    } catch (e) {
      throw GetExerciseFailure();
    }
  }

  Future<NotificationData> getNotifications({
    required Map<String, Object> headers,
    required int viewed,
    required String orderBy,
  }) async {
    try {
      final viewedParam = viewed != -1 ? 'viewed=$viewed' : '';

      final res = await _authRestClient.doHttpGet(
        '/api/v1/member/announce/notifications?orderBy=$orderBy&$viewedParam',
        headers: headers,
      );

      final notiData = NotificationData.fromMap(res['data']);
      return notiData;
    } catch (e) {
      throw GetNotificationsFailure();
    }
  }

  Future<NotificationItem> getNotiDetail({
    required Map<String, Object> headers,
    required int id,
  }) async {
    try {
      final res = await _authRestClient.doHttpGet(
        '/api/v1/member/announce/notification/$id',
        headers: headers,
      );

      final notiDetail = NotificationItem.fromMap(res['data']);
      return notiDetail;
    } catch (e) {
      throw GetNotiDetailFailure();
    }
  }

  Future<List<LeaveData>> getLeaves(
      {required int classId,
      required int pupilId,
      required int schoolId,
      required String schoolBrand}) async {
    try {
      final data = await _authRestClient.doHttpGet(
          '/api/v1/member/leave-application/pupil?class_id=$classId&pupil_id=$pupilId',
          headers: {'School-Id': schoolId, 'School-Brand': schoolBrand});
      final dataList = data['data']['data'] as List<dynamic>;
      List<LeaveData> dataLeaves = [];
      for (final item in dataList) {
        dataLeaves.add(LeaveData.fromJson(item));
      }
      return dataLeaves;
    } catch (e) {
      return [];
    }
  }

  Future<WeekSchedule> getWeekSchedule({
    required String userKey,
    required String txtDate,
  }) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
          '/api.php?act=weeklyplan&user_key=$userKey&txt_date=$txtDate');
      final weekSchedule = WeekSchedule.fromJson(data);
      return weekSchedule;
    } catch (e) {
      print('error: $e');
      throw GetWeekScheduleFailure();
    }
  }

  Future<ScoreModel> getMoetScore(
      String userKey, String txtHocKy, String txtYear) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
        '/api.php?act=show_score&user_key=$userKey&txt_hoc_ky=$txtHocKy&txt_learn_year=$txtYear',
      );

      final scoreRes = ScoreModel.fromMap(data);
      return scoreRes;
    } catch (e) {
      throw GetScoreFailure();
    }
  }

  Future<EslScore> getEslScore(
    String userKey,
    String txtTerm,
    String txtYear,
  ) async {
    try {
      final txtHocKy = (txtTerm == 'Học kỳ 1' || txtTerm == '1') ? '1' : '2';

      final data = await _partnerTokenRestClient.doHttpGet(
          '/api.php?act=esl_score&user_key=0253220010&txt_hoc_ky=$txtHocKy&txt_learn_year=$txtYear');
      final res = EslScore.fromMap(data);

      return res;
    } catch (e) {
      throw GetScoreFailure();
    }
  }

  Future<PrimaryConduct> getPrimaryConduct(
    String userKey,
    String txtHocKy,
    String txtYear,
    String hkTihValue,
  ) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
          '/api.php?act=show_hkth&user_key=$userKey&learn_year=$txtYear&txt_hoc_ky=$txtHocKy&hk_tih_value=$hkTihValue');
      final res = PrimaryConduct.fromMap(data);

      return res;
    } catch (e) {
      throw GetPrimaryConductFailure();
    }
  }

  Future<List<AttendanceDay>> getAttendanceDay({
    required String date,
    required int pupilId,
    required int classId,
    required int schoolId,
    required String type,
    required String schoolBrand,
  }) async {
    try {
      final data = await _client.doHttpGet(
          '/api/v1/member/attendance/pupil?pupil_id=$pupilId&class_id=$classId&date=$date&attendance_type=$type',
          headers: {'School-Id': schoolId, 'School-Brand': schoolBrand});

      final dataList = data['data'] as List<dynamic>;

      final List<AttendanceDay> dataAttendanceDay = [];
      for (final item in dataList) {
        dataAttendanceDay.add(AttendanceDay.fromJson(item));
      }
      return dataAttendanceDay;
    } catch (e) {
      print('error: $e');
      return [];
    }
  }

  Future<AttendanceWeek> getAttendanceWeek(
      {required int pupilId,
      required int classId,
      required int schoolId,
      required String schoolBrand,
      required String startDate,
      required String endDate}) async {
    try {
      final data = await _client.doHttpGet(
          '/api/v1/member/attendance/report?pupil_id=$pupilId&class_id=$classId&start_date=$startDate&end_date=$endDate',
          headers: {'School-Id': schoolId, 'School-Brand': schoolBrand});
      final attendanceData = AttendanceWeek.fromJson(data['data']);
      return attendanceData;
    } catch (e) {
      print('error: $e');
      throw GetWeekScheduleFailure();
    }
  }

  Future<AttendanceWeek> getAttendanceMonth(
      {required int pupilId,
      required int classId,
      required int schoolId,
      required String schoolBrand,
      required String startDate,
      required String endDate}) async {
    try {
      final data = await _client.doHttpGet(
          '/api/v1/member/attendance/report?pupil_id=$pupilId&class_id=$classId&start_date=$startDate&end_date=$endDate',
          headers: {'School-Id': schoolId, 'School-Brand': schoolBrand});
      final attendanceData = AttendanceWeek.fromJson(data['data']);
      return attendanceData;
    } catch (e) {
      throw GetWeekScheduleFailure();
    }
  }

  Future<AlbumData> getAlbum({
    required String pupilId,
  }) async {
    try {
      final data = await _authRestClient.doHttpGet(
        '/api/v1/member/gallery/pupil?pupil_id=$pupilId',
      );
      final albumData = AlbumData.fromJson(data['data']);
      return albumData;
    } catch (e) {
      throw GetAlbumFailure();
    }
  }

  Future<Menu> getMenu({
    required String userKey,
    required String date,
  }) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
          '/api.php?act=weeklymenu&type=json&user_key=$userKey&txt_date=$date');
      return Menu.fromJson(data);
    } catch (e) {
      throw GetMenuFailure();
    }
  }

  Future<List<PhoneBookStudent>> getPhoneBookStudent(
      {required int classId}) async {
    try {
      final data = await _authRestClient
          .doHttpGet('/api/v1/member/class/$classId/pupils');
      final dataList = data['data'] as List<dynamic>;
      List<PhoneBookStudent> dataPhoneBook = [];
      for (final item in dataList) {
        dataPhoneBook.add(PhoneBookStudent.fromJson(item));
      }
      return dataPhoneBook;
    } catch (e) {
      return [];
    }
  }

  Future<List<PhoneBookTeacher>> getPhoneBookTeacher(
      {required int pupilId}) async {
    try {
      final data = await _authRestClient
          .doHttpGet('/api/v1/member/teacher/pupil?pupil_id=10044749');
      final dataList = data['data']['items'] as List<dynamic>;
      List<PhoneBookTeacher> dataPhoneBook = [];
      for (final item in dataList) {
        dataPhoneBook.add(PhoneBookTeacher.fromJson(item));
      }
      return dataPhoneBook;
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>> postLeave({
    String? content,
    required int pupilId,
    required String startDate,
    required String endDate,
    required int leaveType,
    required int schoolId,
    required String schoolBrand,
  }) async {
    final data = await _authRestClient.doHttpPost(
        url: '/api/v1/member/leave-application/pupil',
        requestBody: {
          'content': content,
          'pupil_id': pupilId,
          'start_date': startDate,
          'end_date': endDate,
          'leave_type': leaveType
        },
        headers: {
          'School-Id': schoolId,
          'School-Brand': schoolBrand
        });
    print('error: ${data['message']}');
    return data;
  }

  Future<Nutrition> getNutrition({required String userKey}) async {
    try {
      final token = await _client.getAccessToken();
      final data = await _partnerTokenRestClient.doHttpGet(
          '/api.php?act=health&type=json&user_key=$userKey',
          headers: {'Parter-Token': token});

      return Nutrition.fromJson(data);
    } catch (e) {
      throw GetMenuFailure();
    }
  }

  Future<List<BusScheduleData>> getBusSchedules({
    required int pupilId,
    required int schoolId,
    required String schoolBrand,
    required String startDate,
  }) async {
    final data = await _authRestClient.doHttpGet(
      '/api/v1/member/school-bus/attendance/?pupil_id=$pupilId&start_date=$startDate&end_date=$startDate',
      headers: {
        'School-Id': schoolId,
        'School-Brand': schoolBrand,
      },
    );
    final dataList = data['data'] as List<dynamic>?;
    return dataList?.map((e) => BusScheduleData.fromJson(e)).toList() ?? [];
  }

  Future<List<Message>> getlistMessage(
      {required int page,
      required int schoolId,
      required String schoolBrand}) async {
    try {
      final data = await _client.doHttpGet('/api/v1/member/conversations',
          headers: {'School-Id': '125', 'School-Brand': 'uka'});
      final dataList = data['data']['data'] as List<dynamic>?;
      return dataList?.map((e) => Message.fromJson(e)).toList() ?? [];
    } catch (e) {
      print('error: $e');
      return [];
    }
  }

  Future<List<Comment>> getComment(
      {required String userKey, required String txtDate, required}) async {
    try {
      final token = await _client.getAccessToken();
      final data = await _partnerTokenRestClient.doHttpGet(
          '/api.php?act=teacher_comment_mn&user_key=$userKey&txt_date=$txtDate',
          headers: {'Parter-Token': token});
      final dataList = data['data_comment'] as List<dynamic>?;
      return dataList?.map((e) => Comment.fromJson(e)).toList() ??
          [Comment.empty()];
    } catch (e) {
      return [];
    }
  }

  Future<List<ListReportStudent>> getListReportStudent(
      {required int pupilId,
      required int semester,
      required int schoolId,
      required String schoolBrand,
      required String learnYear}) async {
    try {
      final data = await _authRestClient.doHttpGet(
          '/api/v1/member/bieu-mau-danh-gia/completed?pupil_id=$pupilId&learn_year=$learnYear&semester=$semester',
          headers: {"School-Id": schoolId, "School-Brand": schoolBrand});
      final dataList = data['data']['data'] as List<dynamic>?;
      return dataList?.map((e) => ListReportStudent.fromJson(e)).toList() ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<ReportStudent> getReportStudent(
      {required int id,
      required int pupilId,
      required int schoolId,
      required String schoolBrand}) async {
    try {
      final data = await _authRestClient.doHttpGet(
          '/api/v1/member/bieu-mau-danh-gia/result?id=$id&pupil_id=$pupilId',
          headers: {"School-Id": schoolId, "School-Brand": schoolBrand});

      final jsonData = data['data'] as Map<String, dynamic>;
      return ReportStudent.fromJson(jsonData);
    } catch (e) {
      print('errror: $e');
      throw GetReportStudentFailure();
    }
  }

  Future<List<SurveyData>> getSurvay() async {
    try {
      final data =
          await _authRestClient.doHttpGet('/api/v1/member/survey/question');
      final jsonData = data['data'] as List<dynamic>;
      return jsonData.map((e) => SurveyData.fromJson(e)).toList();
    } catch (e) {
      print('error: $e');
      return [];
    }
  }

  Future<void> postSurvey(
      {required List<Map<String, dynamic>> listSurvey}) async {
    try {
      List<Map<String, dynamic>> requestBody = [];
      for (var survey in listSurvey) {
        Map<String, dynamic> item = {
          "CAU_HOI_ID": survey['cauHoiId'],
          "KHAO_SAT_ID": 1
        };
        if (survey.containsKey('cauTraLoiId')) {
          item["MUC_DO_HAI_LONG"] = survey['cauTraLoiId'];
        }
        if (survey.containsKey('traLoiKhac')) {
          item["TRA_LOI_KHAC"] = survey['traLoiKhac'];
        }
        requestBody.add(item);
      }
      print('d: $requestBody');
      final data = await _authRestClient.doHttpPost(
        url: '/api/v1/member/survey/question',
        data: requestBody,
      );
      print('jiji: $requestBody');
      print('ok: $data');
    } catch (e) {
      print('error');
    }
  }

  Future<String> getAttendanceType({
    required int schoolId,
    required String schoolBrand,
  }) async {
    final token = await _client.getAccessToken();
    print('$token');
    final data = await _authRestClient
        .doHttpGet('/api/v1/staff/attendance/get_attendance_type');
    final dataType = data['data']['type'];
    print('type: $dataType');
    return dataType;
  }
}

class GetNotificationsFailure implements Exception {}

class GetNotiDetailFailure implements Exception {}

class GetWeekScheduleFailure implements Exception {}

class GetReportStudentFailure implements Exception {}

class GetAlbumFailure implements Exception {}

class GetMenuFailure implements Exception {}

class GetPrimaryConductFailure implements Exception {}
