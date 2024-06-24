import 'dart:developer';
import 'dart:io';
import 'dart:js_interop';

import 'package:core/core.dart';
import 'package:core/data/models/list_attendance_bus.dart';
import 'package:core/data/models/observation_model.dart';

import '../../network_data_source.dart';

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

  Future<LearnYear> getLearnYearList(int schoolId) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
        '/api.php',
        queryParameters: {
          'act': 'learn_year',
          'school_id': schoolId,
        },
      );

      final learnYearData = LearnYear.fromMap(data);
      return learnYearData;
    } catch (e) {
      return LearnYear.empty();
    }
  }

  Future<WeeklyLessonData> getRegisterNoteBook({
    required String userKey,
    required String txtDate,
    required int classSelect,
  }) async {
    String type = '';
    if (classSelect == 1) {
      type = 'weeklylesson_teacher_gvcn';
    } else {
      type = 'weeklylesson_teacher';
    }
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
          '/api/api.php?act=$type&type=json&user_key=$userKey&txt_date=$txtDate');

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
          // '/api.php?act=timetable_week&user_key=$userKey&txt_date=$txtDate');
          '/api.php?act=timetable_week&user_key=02033200186&txt_date=$txtDate');

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
        '/api/v1/staff/announce/notifications/list-received?orderBy=$orderBy&$viewedParam',
        headers: headers,
      );

      final notiData = NotificationData.fromMap(res['data']);
      return notiData;
    } catch (e) {
      throw GetNotificationsFailure();
    }
  }

  Future<NotificationData> getSentNoti({
    required Map<String, Object> headers,
    required String status,
    required String orderBy,
  }) async {
    try {
      final res = await _authRestClient.doHttpGet('/api/v1/staff/notifications',
          headers: headers,
          queryParameters: {
            'status': status,
            'orderBy': orderBy,
          });

      final sentNotiData = NotificationData.fromMap(res['data']);
      return sentNotiData;
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

  Future<SentNotiDetail> getNotiDetailTeacher({
    required Map<String, Object> headers,
    required int id,
  }) async {
    try {
      final res = await _authRestClient.doHttpGet(
        '/api/v1/staff/notifications/$id',
        headers: headers,
      );

      final notiDetail = SentNotiDetail.fromMap(res['data']);
      return notiDetail;
    } catch (e) {
      throw GetNotiDetailFailure();
    }
  }

  Future<List<LeaveTeacher>> getLeavesTeacher(
      {required String status,
      required String startDate,
      required int schoolId,
      required String schoolBrand}) async {
    try {
      final data = await _authRestClient.doHttpGet(
          '/api/v1/staff/leave-application/teacher',
          queryParameters: {
            'status': status,
            'start_date': startDate,
          },
          headers: {
            'School-Id': schoolId,
            'School-Brand': schoolBrand,
          });

      final dataList = data['data']['data'] as List<dynamic>?;
      print('dataList: $dataList');
      return dataList?.map((e) => LeaveTeacher.fromMap(e)).toList() ?? [];
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

  Future<Map<String, dynamic>> getMessageDetail({
    required String conversationId,
    required int schoolId,
    required String schoolBrand,
    int? page = 1,
  }) async {
    try {
      final data = await _client
          .doHttpGet('/api/v1/staff/conversations/$conversationId', headers: {
        'School_Id': schoolId,
        'School_Brand': schoolBrand,
      }, queryParameters: {
        'page': page,
      });
      final dataList = data['data']['data'] as List<dynamic>?;

      final res = {
        "data": dataList,
        "last_page": data['data']['meta']['last_page'],
        "current_page": data['data']['meta']['current_page'],
      };
      return res;
    } catch (e) {
      return {};
    }
  }

  Future<int> postMessage({
    required String content,
    required String classId,
    required String recipient,
    required int schoolId,
    required String schoolBrand,
  }) async {
    try {
      var formData = FormData.fromMap(
        {
          "content": content,
          "class_id": classId,
          "recipient": "${[recipient]}",
        },
      );
      // final data = await _client.doHttpPost(
      //     url: '/api/v1/member/messages',
      //     headers: {
      //       'School_Id': schoolId,
      //       'School_Brand': schoolBrand,
      //     },
      //     requestBody: formData);

      final res = await _client.dio.post('/api/v1/member/messages',
          options: Options(headers: {
            'School_Id': schoolId,
            'School_Brand': schoolBrand,
          }),
          data: formData);
      return res.data['data']['conversation_id'];
    } catch (e) {
      Log.e(e.toString());
      return 0;
    }
  }

  Future<Map<String, dynamic>> createNewAlbum({
    required String learnYear,
    required int classId,
    required String galleryName,
    required List<File> listFiles,
    required int teacherId,
  }) async {
    var formData = FormData.fromMap(
      {
        "learn_year": learnYear,
        "class_id": classId,
        "gallery_name": galleryName,
        "status": 1,
      },
    );

    for (int i = 0; i < listFiles.length; i++) {
      formData.files.add(MapEntry(
        'files[$i]',
        MultipartFile.fromFileSync(listFiles[i].path),
      ));
    }

    final data = await _authRestClient.dio.post(
      '/api/v1/staff/gallery/store',
      data: formData,
    );

    return data.data;
  }

  Future<Map<String, dynamic>> createNewNoti({
    required List<int> listPupilId,
    required int classId,
    required String type,
    required String title,
    required String content,
    required String status,
    required List<File> listFiles,
    required Map<String, dynamic> headers,
  }) async {
    // parse listPupilId to sample [10055489, 10045775], includes []
    var pupilId = listPupilId.toString();
    print(pupilId);
    var formData = FormData.fromMap(
      {
        "pupil_id": pupilId,
        "class_id": classId,
        "type": type,
        "title": title,
        "content": content,
        "status": status,
      },
    );

    for (int i = 0; i < listFiles.length; i++) {
      formData.files.add(MapEntry(
        'attachment[$i]',
        MultipartFile.fromFileSync(listFiles[i].path),
      ));
    }

    final data = await _authRestClient.dio.post(
        '/api/v1/staff/announce/notifications/create',
        data: formData,
        options: Options(headers: headers));

    return data.data;
  }

  Future<int> deleteMessageDetail({
    required String content,
    required int schoolId,
    required String schoolBrand,
    required String recipient,
    required int idMessage,
  }) async {
    try {
      final data = await _client.doHttpDelete(
        url: '/api/v1/member/messages/$idMessage',
        headers: {
          'School_Id': schoolId,
          'School_Brand': schoolBrand,
        },
        requestBody: {
          "content": content,
          "recipient": [recipient]
        },
      );
      return data['code'];
    } catch (e) {
      return 0;
    }
  }

  Future<int> deleteMessage({
    required int schoolId,
    required String schoolBrand,
    required int idMessage,
  }) async {
    try {
      final data = await _client.doHttpDelete(
        url: '/api/v1/member/conversations/$idMessage',
        headers: {
          'School_Id': schoolId,
          'School_Brand': schoolBrand,
        },
      );
      return data['code'];
    } catch (e) {
      return 0;
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

  Future<AlbumData> getAlbum(String teacherId) async {
    try {
      final data = await _authRestClient.doHttpGet(
        '/api/v1/staff/gallery/teacher?teacher_id=$teacherId',
      );

      final albumData = AlbumData.fromJson(data['data']);
      return albumData;
    } catch (e) {
      throw GetAlbumFailure();
    }
  }

  Future<List<String>> getListYear(int number) async {
    try {
      final data = await _authRestClient.doHttpGet(
        '/api/v1/staff/gallery/learnyear',
        queryParameters: {
          'number': number,
        },
      );

      final listLearnYear = (data['data'] as List<dynamic>).cast<String>();

      return listLearnYear;
    } catch (e) {
      return [];
    }
  }

  Future<List<GalleryClass>> getListClass(String learnYear) async {
    try {
      final data = await _authRestClient.doHttpGet(
        '/api/v1/staff/gallery/class',
        queryParameters: {
          'learn_year': learnYear,
        },
      );

      final listClass = (data['data']['items'] as List<dynamic>)
          .map((e) => GalleryClass.fromMap(e))
          .toList();

      return listClass;
    } catch (e) {
      return [];
    }
  }

  Future<List<NotiClass>> getListClassNoti(
      String learnYear, int teacherId) async {
    try {
      final data = await _authRestClient.doHttpGet(
        '/api/v1/staff/class/teacher',
        queryParameters: {
          'learn_year': learnYear,
          'teacher_id': teacherId,
        },
      );

      final listClass = (data['data']['data'] as List<dynamic>)
          .map((e) => NotiClass.fromMap(e))
          .toList();

      return listClass;
    } catch (e) {
      return [];
    }
  }

  Future<List<PupilInClass>> getPupilInClass(
      Map<String, dynamic> headers, int classId) async {
    try {
      final data = await _authRestClient.doHttpGet(
        '/api/v1/staff/class/$classId/pupils',
        headers: headers,
      );

      print(data);

      final listPupilInClass = (data['data'] as List<dynamic>)
          .map((e) => PupilInClass.fromJson(e))
          .toList();

      return listPupilInClass;
    } catch (e) {
      return [];
    }
  }

  Future<Menu> getMenu({
    required String userKey,
    required String date,
  }) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
          '/api/api.php?act=weeklymenu&type=json&user_key=0282810220108&txt_date=4-03-2024');
      return Menu.fromJson(data);
    } catch (e) {
      throw GetMenuFailure();
    }
  }

  Future<List<PhoneBookStudent>> getPhoneBookStudent(
      {required int classId}) async {
    try {
      final data = await _authRestClient
          .doHttpGet('/api/v1/staff/class/$classId/pupils');
      // final data = await _authRestClient.doHttpGet('/api/v1/staff/pupil/class');
      log(data.toString());
      final dataList = data['data'] as List<dynamic>?;

      if (dataList == null) {
        return [];
      }

      List<PhoneBookStudent> dataPhoneBook = [];
      for (final item in dataList) {
        dataPhoneBook.add(PhoneBookStudent.fromJson(item));
      }
      log('dataPhoneBook: $dataPhoneBook');

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

  Future<Map<String, dynamic>> approveLeave({
    required int pupilId,
    required String startDate,
    required String endDate,
    required int schoolId,
    required String schoolBrand,
  }) async {
    final data = await _authRestClient.doHttpPost(
        url: '/api/v1/staff/leave-application/item/1',
        requestBody: {
          'pupil_id': pupilId,
          'start_date': startDate,
          'end_date': endDate,
          'status': 'approved',
        },
        headers: {
          'School-Id': schoolId,
          'School-Brand': schoolBrand
        });
    print('error: ${data['message']}');
    return data;
  }

  Future<Map<String, dynamic>> approveAllLeaves({
    required List<int> ids,
    required int schoolId,
    required String schoolBrand,
  }) async {
    final data = await _authRestClient.doHttpPost(
        url: '/api/v1/member/leave-application/pupil',
        requestBody: {'ids': ids},
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand});
    print('approveAllLeaves $data');
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

  Future<Map<String, dynamic>?> postPinMessage({
    required String schoolBrand,
    required int schoolId,
    required int idMessage,
  }) async {
    try {
      final data = await _client.doHttpPost(
        url: '/api/v1/member/message/$idMessage/pin',
        headers: {
          'School_Brand': schoolBrand,
          'School_Id': schoolId,
        },
      );
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> postDeletePinMessage({
    required String schoolBrand,
    required int schoolId,
    required int idMessage,
  }) async {
    try {
      final data = await _client.doHttpPost(
        url: '/api/v1/member/message/$idMessage/un-pin',
        headers: {
          'School_Brand': schoolBrand,
          'School_Id': schoolId,
        },
      );
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<MessageDetail?> getMessagePin({
    required String schoolBrand,
    required int schoolId,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/member/message/pinned',
        headers: {
          'School_Brand': schoolBrand,
          'School_Id': schoolId,
        },
      );
      final jsonData = data['data'] as Map<String, dynamic>;
      return MessageDetail.fromJson(jsonData);
    } catch (e) {
      return null;
    }
  }

  Future<List<Message>> getlistMessage({
    required int schoolId,
    required String classId,
    required String userId,
    required String schoolBrand,
  }) async {
    try {
      final data = await _client.doHttpGet(
          '/api/v1/member/conversations?class_id=$classId&user_id=$userId',
          headers: {'School-Id': schoolId, 'School-Brand': schoolBrand});
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
          '/api/api.php?act=teacher_comment_mn&user_key=$userKey&txt_date=$txtDate',
          headers: {'Parter-Token': token});
      final dataList = data['data_comment'] as List<dynamic>?;
      return dataList?.map((e) => Comment.fromJson(e)).toList() ??
          [Comment.empty()];
    } catch (e) {
      return Comment.fakeData();
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

  Future<List<Survey>> getSurveyList() async {
    try {
      final data = await _client.doHttpGet('/api/v1/staff/survey/list');
      final jsonData = data['data']['items'] as List<dynamic>;
      return jsonData.map((e) => Survey.fromJson(e)).toList();
    } catch (e) {
      print('error: $e');
      return [];
    }
  }

  Future<SurveyDetail> getSurveyDetail(int khaoSatId) async {
    try {
      final data = await _authRestClient
          .doHttpGet('/api/v1/member/survey/question', queryParameters: {
        'khao_sat_id': khaoSatId,
      });

      print(data);

      final surveyDetailData = SurveyDetail.fromMap(data['data']);
      return surveyDetailData;
    } catch (e) {
      throw GetSurveyDetailFailure();
    }
  }

  Future<void> postSurvey({
    required List<Map<String, dynamic>> listSurvey,
    required int khaoSatId,
  }) async {
    try {
      List<Map<String, dynamic>> requestBody = [];
      for (var survey in listSurvey) {
        Map<String, dynamic> item = {
          "KHAO_SAT_ID": khaoSatId,
          "CAU_HOI_ID": survey['cauHoiId'],
          "LOAI_CAU_HOI": survey['loaiCauHoi'],
        };
        if (survey.containsKey('cauTraLoiId')) {
          item["MUC_DO_HAI_LONG"] = survey['cauTraLoiId'];
        }
        if (survey.containsKey('traLoiKhac')) {
          item["TRA_LOI_KHAC"] = survey['traLoiKhac'];
        }
        requestBody.add(item);
      }
      print('requestBody: $requestBody');
      final data = await _authRestClient.doHttpPost(
        url: '/api/v1/staff/survey/question',
        data: requestBody,
      );
      print('data: $data');
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

  Future<List<ClassTeacher>> getListClassTeacher({
    required int teacherId,
    required String schoolBrand,
    required int schoolId,
  }) async {
    try {
      DateTime now = DateTime.now();
      String learnYear;
      if (now.month > 8) {
        learnYear = '${now.year}-${now.year + 1}';
      } else {
        learnYear = '${now.year - 1}-${now.year}';
      }

      final data = await _authRestClient.doHttpGet(
        '/api/v1/staff/class/teacher?teacher_id=$teacherId&learn_year=$learnYear',
        headers: {
          'School-Id': schoolId,
          'School-Brand': schoolBrand,
        },
      );
      final jsonData = data['data']['data'] as List<dynamic>;
      return jsonData.map((e) => ClassTeacher.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<AttendanceWeek> getAttendanceWeekTeacher({
    required int classId,
    required String startDate,
    required String endDate,
    required int schoolId,
    required String schoolBrand,
  }) async {
    final token = await _client.getAccessToken();
    print('$token');
    try {
      final data = await _client.doHttpGet(
          '/api/v1/staff/attendance/report?class_id=$classId&start_date=$startDate&end_date=$endDate',
          headers: {'School-Id': schoolId, 'School-Brand': schoolBrand});
      final attendanceData = AttendanceWeek.fromJson(data['data']);
      return attendanceData;
    } catch (e) {
      throw GetWeekScheduleFailure();
    }
  }

  Future<List<AttendanceTeacher>> getAttendanceClassTeacher({
    required String date,
    required int schoolId,
    required String schoolBrand,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/timetable/get_by_teacher?date=$date',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      final jsonData = data['data'] as List<dynamic>;
      return jsonData.map((e) => AttendanceTeacher.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<AttendanceTeacher>> getAttendanceClassLeader({
    required String date,
    required int schoolId,
    required String schoolBrand,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/timetable/get_by_form_teacher?date=$date',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      final jsonData = data['data'] as List<dynamic>;
      return jsonData.map((e) => AttendanceTeacher.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<ListAttendanceModel>> getListAttendance({
    required int classId,
    required int numberOfClassPeriod,
    int? subjectId,
    required String date,
    required String type,
    required int schoolId,
    required String schoolBrand,
  }) async {
    try {
      String subjectId;
      subjectId = '';
      final data = await _client.doHttpGet(
        '/api/v1/staff/attendance/pupils?class_id=$classId&number_of_class_period=$numberOfClassPeriod$subjectId&date=$date&type=$type',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      final jsonData = data['data'] as List<dynamic>;
      return jsonData.map((e) => ListAttendanceModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>?> postAttendance({
    required String type,
    required int numberOfClasspriod,
    required int classId,
    required int subject,
    required int roomId,
    required String roomTitle,
    required String date,
    required List<AttendanceDataList> attendanceData,
    required String schoolBrand,
    required int schoolId,
  }) async {
    try {
      final data = await _client.doHttpPost(
        url: '/api/v1/staff/attendance/pupil/bulk-insert',
        requestBody: {
          "type": type,
          "number_of_class_period": numberOfClasspriod,
          "class_id": classId,
          "subject_id": subject,
          "room_id": roomId,
          "room_title": roomTitle,
          "date": date,
          "pupils": attendanceData
        },
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> postTakeAttendanceOfEachStudent({
    required int schoolId,
    required String schoolBrand,
    required int pupilId,
    required String type,
    required int attendanceId,
    required int scheduleId,
  }) async {
    final data = await _client.doHttpPost(
        url: '/api/v1/staff/school-bus/bus-attendance/update-attendance',
        headers: {
          'School-Id': schoolId,
          'School-Brand': schoolBrand
        },
        requestBody: {
          "pupil_id": pupilId,
          "type": type,
          "attendance_id": attendanceId,
          "schedule_id": scheduleId
        });
    return data;
  }

  Future<Map<String, dynamic>> postUpdateAbsentBus({
    required int schoolId,
    required String schoolBrand,
    required int pupilId,
    required int attendanceId,
    required int scheduleId,
  }) async {
    final data = await _client.doHttpPost(
        url: '/api/v1/staff/school-bus/bus-attendance/attendance-absent',
        headers: {
          'School-Id': schoolId,
          'School-Brand': schoolBrand
        },
        requestBody: {
          "pupil_id": pupilId,
          "attendance_id": attendanceId,
          "schedule_id": scheduleId
        });
    return data;
  }

  Future<DetailBusSchedule> getDetailBusSchedule({
    required String schoolBrand,
    required int schoolId,
    required int idBus,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/school-bus/bus-schedule/$idBus/attendance',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      return DetailBusSchedule.fromJson(data['data']);
    } catch (e) {
      throw GetBusSchudeleFailure();
    }
  }

  Future<List<ListAttendanceBus>> getListAttendanceBus({
    required int schoolId,
    required String schoolBrand,
    required int busId,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/school-bus/bus-stop/list-attendance?bus_schedule_id=$busId',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      final jsonData = data['data'] as List<dynamic>;
      return jsonData.map((e) => ListAttendanceBus.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<BusScheduleTeacher>> getBusScheduleTeacher({
    required String startDate,
    required String endDate,
    required String schoolBrand,
    required int schoolId,
  }) async {
    try {
      final token = await _client.getAccessToken();
      print('$token');
      final data = await _client.doHttpGet(
        '/api/v1/staff/school-bus/bus-schedules?start_date=$startDate&end_date=$endDate',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      final jsonData = data['data'] as List<dynamic>;
      return jsonData.map((e) => BusScheduleTeacher.fromJson(e)).toList();
    } catch (e) {
      print('error: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> turnOffNoti(
      {required int pushNotify, required Map<String, Object> headers}) async {
    try {
      final data = await _client.doHttpPost(
        url: '/api/v1/staff/notifications/switch',
        requestBody: {'status': pushNotify},
        headers: headers,
      );
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<List<Pupils>> getEditAttendanceBus({
    required int schoolId,
    required String schoolBrand,
    required int busId,
  }) async {
    final data = await _client.doHttpGet(
      '/api/v1/staff/school-bus/bus-schedules/list-attendance?bus_schedule_id=$busId',
      headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
    );
    final jsonData = data['data']['data'] as List<dynamic>;
    return jsonData.map((e) => Pupils.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> postEditAttendanceBus({
    required String type,
    required int schedule,
    required List<Map<String, dynamic>> listEdit,
  }) async {
    final data = await _client.doHttpPost(
        url: '/api/v1/staff/school-bus/bus-attendance/mass-update',
        requestBody: {
          "type": type,
          "schedule_id": schedule,
          "data": listEdit,
        });
    return data;
  }

  Future<List<ObservationData>> getLessonRegister({
    required String userKey,
    required int schoolId,
    required String txtDate,
    required String teacherId,
  }) async {
    try {
      final data = await _partnerTokenRestClient
          .doHttpGet('/api.php?act=get_lesson_register', queryParameters: {
        'user_key': userKey,
        'txt_date': txtDate,
        'teacher_id': teacherId,
      });

      if (data['data'] == null) {
        return [];
      }

      final jsonData = data['data'] as List<dynamic>;
      return jsonData.map((e) => ObservationData.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<RegisteredLesson>> getLessonRegistered({
    required String userKey,
    required String txtDate,
  }) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
        '/api.php?act=lesson_register',
        queryParameters: {
          'user_key': userKey,
          'date_from': txtDate,
          'date_to': txtDate,
          // "user_key": "duongvt.quynhon",
          // "date_from": "26-02-2024",
          // "date_to": "26-02-2024",
        },
      );

      if (data['data'] == null) {
        return [];
      }

      final jsonData = data['data'] as List<dynamic>;
      return jsonData
          .map((e) => RegisteredLesson.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<TeacherItem>> getTeacherListBySchool({
    required int schoolId,
  }) async {
    try {
      final res = await _client.doHttpGet(
        '/api.php?act=list_teacher&school_id=$schoolId',
      );

      final jsonData = res['data'] as List<dynamic>;
      return jsonData.map((item) => TeacherItem.fromJson(item)).toList();
    } catch (e) {
      print('error: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> getTeacherListByTeacherId({
    required int teacherId,
  }) async {
    final response = await _client.doHttpGet(
      '/api/v1/staff/teacher/?teacher_id=$teacherId',
    );

    return response;
  }

  Future<Map<String, dynamic>> getListSubject({
    required int schoolId,
  }) async {
    final response = await _client.doHttpGet(
      '/api.php?act=list_subject&school_id=$schoolId',
    );

    return response;
  }

  Future<Map<String, dynamic>> getListClassBySchool({
    required int schoolId,
    required String learnYear,
  }) async {
    final response = await _client.doHttpGet(
      '/api.php?act=list_class&school_id=$schoolId&learn_year=$learnYear',
    );

    return response;
  }

  Future<List<Semester>> getSemester({
    required int schoolId,
    required String schoolBrand,
    required String capDaoTao,
  }) async {
    final data = await _client.doHttpGet(
      '/api/v1/staff/mark/get-semester?cap_dao_tao=$capDaoTao',
      headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
    );
    final jsonData = data['data'] as List<dynamic>;
    return jsonData.map((e) => Semester.fromJson(e)).toList();
  }

  Future<List<ClassScore>> getListClassScore(
      {required int schoolId,
      required String schoolBrand,
      required String learnYear}) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/teacher/class/subject?learn_year=2023-2024',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      final dataJson = data['data'] as List<dynamic>;
      return dataJson.map((e) => ClassScore.fromJson(e)).toList();
    } catch (e) {
      print('$e');
      return [];
    }
  }

  Future<FormInputScore> getFormInputScore({
    required int schoolId,
    required String schoolBrand,
    required int classId,
    required int subjectId,
    required String learnYear,
    required int semester,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/mark/form?class_id=$classId&subject_id=$subjectId&learn_year=$learnYear&semester=$semester',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );

      // Check if the response is a list
      if (data['data'] is List) {
        // Convert the list to a map with an "items" key
        return FormInputScore.fromJson(
            {'cap_dao_tao': 'default_value', 'items': data['data']});
      } else {
        // Otherwise, assume it's already a map
        final jsonData = data['data'] as Map<String, dynamic>;
        return FormInputScore.fromJson(jsonData);
      }
    } catch (e) {
      print('error: $e');
      throw GetAlbumFailure();
    }
  }

  Future<Map<String, dynamic>> postLessonRegister({
    required String userKey,
    required String txtDate,
    required int schoolId,
    required int teacherId,
    required int tietNum,
    required int classId,
    required int subjectId,
  }) async {
    final response = await _client.doHttpPost(
      url: '/api/api.php?act=post_lesson_register',
      requestBody: {
        'user_key': userKey,
        'txt_date': txtDate,
        'SCHOOL_ID': schoolId,
        'TEACHER_ID': teacherId,
        'TIET_NUM': tietNum,
        'CLASS_ID': classId,
        'SUBJECT_ID': subjectId,
        // "user_key": "duongvt.quynhon",
        // "txt_date": "26-02-2024",
        // "SCHOOL_ID": 104,
        // "TEACHER_ID": 10007523,
        // "TIET_NUM": 9,
        // "CLASS_ID": 5691,
        // "SUBJECT_ID": 52
      },
    );
    return response;
  }

  Future<Map<String, dynamic>> deleteLessonRegistered({
    required String userKey,
    required String lessonRegisterId,
  }) async {
    final response = await _client.doHttpDelete(
      url: '/api/api.php?act=delete_lesson_register',
      requestBody: {
        // "user_key": "duongvt.quynhon",
        'user_key': userKey,
        'lesson_register_id': lessonRegisterId,
      },
    );
    return response;
  }

  Future<MoetEvaluation> getMoetEvaluation({
    required String userKey,
    required String lessonRegisterId,
    required String lessonRegisterIdType,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/api.php?act=lesson_register_note',
        queryParameters: {
          'user_key': userKey,
          'lesson_register_id': lessonRegisterId,
          'lesson_register_id_type': lessonRegisterIdType,
        },
      );

      return MoetEvaluation.fromMap(data);
    } catch (e) {
      return MoetEvaluation.empty();
    }
  }

  Future<Map<String, dynamic>?> updateMoetEvaluation(body) async {
    try {
      final data = await _client.doHttpPost(
        url: '/api/api.php?act=post_lesson_register_note',
        requestBody: body,
      );

      return data;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Map<String, dynamic>> postNutritionHealth({
    required int pupilId,
    required DateTime learnYear,
    required int txtMonth,
    required String typeHeight,
    required String weight,
    required String height,
    required double bmi,
    required String distribute,
  }) async {
    DateTime now = learnYear;
    try {
      String newLearnYear;
      if (now.month > 8) {
        newLearnYear = '${now.year}-${now.year + 1}';
      } else {
        newLearnYear = '${now.year - 1}-${now.year}';
      }
      final token = await _client.getAccessToken();
      final data = await _partnerTokenRestClient.doHttpPost(
        url: '/api/api.php?act=post_health',
        headers: {'Parter-Token': token},
        requestBody: {
          "pupil_id": pupilId,
          "learn_year": newLearnYear,
          "txt_month": txtMonth,
          "type_height": typeHeight,
          "weight": weight,
          "height": height,
          "Distribute": distribute,
          "BMI": bmi
        },
      );
      return data;
    } catch (e) {
      print('$e');
      throw GetAlbumFailure();
    }
  }

  Future<List<Armorial>> getArmorial() async {
    try {
      final token = await _client.getAccessToken();
      final data = await _partnerTokenRestClient.doHttpGet(
        '/api/api.php?act=list_huy_hieu_mn',
        headers: {'Parter-Token': token},
      );

      // Ensure that data is a list of dynamic elements
      final jsonData = data as List<dynamic>;

      // Map each item in jsonData to an Armorial object
      return jsonData
          .map((e) => Armorial.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return Armorial.fakeData();
    }
  }

  Future<Map<String, dynamic>> postScoreComment({
    required String userKey,
    required int pupilId,
    required String weekDay,
    required String commentMnContent,
    required String huyHieuId,
    required String commentMnTitle,
  }) async {
    final token = await _client.getAccessToken();
    final data = await _partnerTokenRestClient.doHttpPost(
      url: '/api/api.php?act=post_comment_mn',
      headers: {'Parter-Token': token},
      requestBody: {
        "user_key": userKey,
        "pupil_id": pupilId,
        "week_day": weekDay,
        "comment_mn_content": commentMnContent,
        "huy_hieu_id": huyHieuId,
        "comment_mn_time": commentMnTitle
      },
    );
    return data;
  }

  Future<List<ListAllForm>> getListAllForm({
    required String schoolBrand,
    required int schoolId,
  }) async {
    try {
      DateTime now = DateTime.now();
      String newLearnYear;
      if (now.month > 8) {
        newLearnYear = '${now.year}-${now.year + 1}';
      } else {
        newLearnYear = '${now.year - 1}-${now.year}';
      }
      final data = await _client.doHttpGet(
        '/api/v1/staff/bieu-mau-danh-gia?learn_year=$newLearnYear',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      final jsonData = data['data']['data'] as List<dynamic>;
      return jsonData.map((e) => ListAllForm.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<ListStudentFormReport>> getListStudentFormReport({
    required int id,
    required int classId,
    required String schoolBrand,
    required int schoolId,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/bieu-mau-danh-gia/pupils?id=$id&class_id=$classId',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      final jsonData = data['data']['items'] as List<dynamic>;
      return jsonData.map((e) => ListStudentFormReport.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<FormDetail> getFormDetail({
    required int id,
    required int pupilId,
    required String schoolBrand,
    required int schoolId,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/bieu-mau-danh-gia/result?id=$id&pupil_id=$pupilId',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      final jsonData = data['data'] as Map<String, dynamic>;
      return FormDetail.fromJson(jsonData);
    } catch (e) {
      return FormDetail.empty();
    }
  }

  Future<Map<String, dynamic>> postUpdateReportTeacher({
    required int pupilId,
    required String evaluationFormId,
    required String commentText,
    required String teacherEvaluation,
    required int classId,
    required List<List<UpdateReport>> updateReport,
    required String schoolBrand,
    required int schoolId,
  }) async {
    try {
      final List<Map<String, dynamic>> newUpdate = [];
      for (var itemList in updateReport) {
        for (var item in itemList) {
          newUpdate.add(updateReportToJson(item));
        }
      }

      final data = await _client
          .doHttpPost(url: '/api/v1/staff/bieu-mau-danh-gia/comment', headers: {
        'School-Id': schoolId,
        'School-Brand': schoolBrand
      }, requestBody: {
        "pupil_id": pupilId.toString(),
        "evaluation_form_id": evaluationFormId,
        "comment_text": commentText,
        "teacher_evaluation": teacherEvaluation,
        "class_id": classId.toString(),
        "list_criterial": newUpdate
      });
      return data;
    } catch (e) {
      throw GetAlbumFailure();
    }
  }

  Future<ViolationData> getViolationData({
    required String userKey,
    required String classId,
  }) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
        '/api/api.php?act=list_pupil_in_class&user_key=$userKey&class_id=$classId',
      );
      return ViolationData.fromMap(data);
    } catch (e) {
      throw GetAlbumFailure();
    }
  }

  Future<List<ListViolation>> getListViolation() async {
    final data = await _partnerTokenRestClient.doHttpGet(
      '/api/api.php?act=list_vi_pham_hs',
    );
    final jsonData = data['data'] as List<dynamic>;
    return jsonData.map((e) => ListViolation.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> postRegisterBook({
    required String lessionId,
    required String lessionTitle,
    required String lessionNote,
    required String tietPpct,
    required String lessionRank,
    required String danDoBaoBai,
    required File fileBaoBai,
    required String linkBaoBai,
    required String hanNop,
    required String userKey,
  }) async {
    var formData = FormData.fromMap(
      {
        "user_key": userKey,
        "lession_id": lessionId,
        "lession_title": lessionTitle,
        "lession_note": lessionNote,
        "tiet_ppct": tietPpct,
        "lession_rank": lessionRank,
        "dan_do_bao_bai": danDoBaoBai,
        "link_bao_bai": linkBaoBai,
        "han_nop": hanNop,
      },
    );
    formData.files.add(
      MapEntry(
        'file_bao_bai',
        MultipartFile.fromFileSync(fileBaoBai.path),
      ),
    );
    final data = await _partnerTokenRestClient.dio.post(
      '/api/api.php?act=weeklylesson_post_new',
      data: formData,
      //options: Options(headers: )
    );
    return data.data;
  }
}

Map<String, dynamic> updateReportToJson(UpdateReport report) {
  return {
    'pupil_id': report.pupil_id,
    'evaluation_form_id': report.evaluation_form_id,
    'criterial_mapping_id': report.criterial_mapping_id,
    'mark_id': report.mark_id,
    'criterial_id': report.criterial_id,
    'other_result_text': report.other_result_text,
  };
}

class UpdateReport {
  final int pupil_id;
  final int evaluation_form_id;
  final int criterial_mapping_id;
  late int mark_id;
  final int criterial_id;
  final String other_result_text;
  UpdateReport({
    required this.criterial_id,
    required this.criterial_mapping_id,
    required this.evaluation_form_id,
    required this.mark_id,
    required this.other_result_text,
    required this.pupil_id,
  });
}

class GetNotificationsFailure implements Exception {}

class GetNotiDetailFailure implements Exception {}

class GetWeekScheduleFailure implements Exception {}

class GetReportStudentFailure implements Exception {}

class GetAlbumFailure implements Exception {}

class GetMenuFailure implements Exception {}

class GetPrimaryConductFailure implements Exception {}

class GetScoreFailure implements Exception {}

class GetExerciseFailure implements Exception {}

class GetRegisterNoteBookFailure implements Exception {}

class GetBusSchudeleFailure implements Exception {}

class GetSurveyDetailFailure implements Exception {}
