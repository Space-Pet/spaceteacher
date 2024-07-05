import 'dart:io';

import 'package:core/core.dart';
import 'package:core/data/models/form_score_esl.dart';
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
        '/api/api.php?act=$type&type=json&user_key=$userKey&txt_date=$txtDate',
      );

      final weeklylessonData = WeeklyLessonData.fromMap(data);
      return weeklylessonData;
    } catch (e) {
      throw GetRegisterNoteBookFailure();
    }
  }

  Future<Schedule> getSchedule(
    String userKey,
    String txtDate,
    int classType,
  ) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
        '/api.php',
        queryParameters: {
          'act': classType == 1
              ? 'timetable_teacher_gvcn_week'
              : 'timetable_teacher_week',
          'user_key': userKey,
          'txt_date': txtDate,
        },
      );

      final scheduleData = Schedule.fromMap(data['data']);
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
            // 'status': status,
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

  Future<Map<String, dynamic>> deleteNoti({
    required int id,
  }) async {
    try {
      final res = await _authRestClient.doHttpDelete(
        url: '/api/v1/staff/notifications/$id',
      );

      return res;
    } catch (e) {
      return {};
    }
  }

  Future<Map<String, dynamic>> deleteNotiFile({
    required int notificationId,
    required int attachmentId,
  }) async {
    try {
      final res = await _authRestClient.doHttpDelete(
          url: '/api/v1/staff/notifications/delete/attachment',
          requestBody: {
            'notification_id': notificationId,
            'attachment_id': attachmentId,
          });

      return res;
    } catch (e) {
      return {};
    }
  }

  Future<Map<String, dynamic>> deleteImagesInGallery({
    required int galleryId,
    required List<int> listId,
  }) async {
    final requestBody = {
      'gallery_id': galleryId,
      'images': listId.map((e) => {'id': e}).toList(),
    };

    try {
      final res = await _authRestClient.doHttpDelete(
        url: '/api/v1/staff/gallery/delete-images',
        requestBody: requestBody,
      );

      return res;
    } catch (e) {
      return {};
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
    String? conversationId,
    String? recipientId,
    bool isGetById = false,
    required int schoolId,
    required String schoolBrand,
    required int page,
  }) async {
    try {
      final slug =
          isGetById ? 'get_conversation_by' : 'conversations/$conversationId';

      final data = await _client.doHttpGet(
        '/api/v1/staff/$slug',
        headers: {
          'School_Id': schoolId,
          'School_Brand': schoolBrand,
        },
        queryParameters: {
          'recipient_id': recipientId,
          'page': page,
        },
      );

      if (data['data'] == null) {
        return {
          "data": [],
          "last_page": 0,
          "current_page": 0,
        };
      }

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
    required List<File> files,
  }) async {
    try {
      var formData = FormData.fromMap(
        {
          "content": content.isEmpty ? 'images' : content,
          "class_id": classId,
          "recipient": "${[recipient]}",
        },
      );

      for (int i = 0; i < files.length; i++) {
        formData.files.add(MapEntry(
          'attachment[$i]',
          MultipartFile.fromFileSync(files[i].path),
        ));
      }

      final res = await _client.dio.post(
        '/api/v1/staff/messages',
        options: Options(headers: {
          'School_Id': schoolId,
          'School_Brand': schoolBrand,
        }),
        data: formData,
      );
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

  Future<Map<String, dynamic>> updateGallery({
    required String learnYear,
    required int classId,
    required String galleryName,
    required List<File> listFiles,
    required int galleryId,
  }) async {
    var formData = FormData.fromMap(
      {
        "learn_year": learnYear,
        "class_id": classId,
        "gallery_name": galleryName,
        "status": 1,
        "gallery_id": galleryId,
      },
    );

    for (int i = 0; i < listFiles.length; i++) {
      formData.files.add(MapEntry(
        'files[$i]',
        MultipartFile.fromFileSync(listFiles[i].path),
      ));
    }

    final data = await _authRestClient.dio.post(
      '/api/v1/staff/gallery/update',
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
    var pupilId = listPupilId.toString();
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

  Future<Map<String, dynamic>> updateDraftNoti({
    required int id,
    required List<int> listPupilId,
    required int classId,
    required String type,
    required String title,
    required String content,
    required String status,
    required List<File> listFiles,
    required Map<String, dynamic> headers,
  }) async {
    var pupilId = listPupilId.toString();
    var formData = FormData.fromMap(
      {
        "id": id,
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
        '/api/v1/staff/notifications/update',
        data: formData,
        options: Options(headers: headers));

    return data.data;
  }

  Future<int> deleteConservation({
    required int schoolId,
    required String schoolBrand,
    required int conservationId,
  }) async {
    try {
      final data = await _client.doHttpDelete(
        url: '/api/v1/staff/conversations/$conservationId',
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

  Future<Map<String, dynamic>> deleteMessage({
    required String content,
    required int schoolId,
    required String schoolBrand,
    required String recipient,
    required int idMessage,
  }) async {
    try {
      final data = await _client.doHttpDelete(
        url: '/api/v1/staff/messages/$idMessage',
        headers: {
          'School_Id': schoolId,
          'School_Brand': schoolBrand,
        },
        requestBody: {
          "content": content,
          "recipient": [recipient]
        },
      );
      return data;
    } catch (e) {
      return {};
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

  Future<Gallery> getGalleryDetail(String teacherId, int galleryId) async {
    try {
      final data = await _authRestClient
          .doHttpGet('/api/v1/staff/gallery/show', queryParameters: {
        'teacher_id': teacherId,
        'gallery_id': galleryId,
      });

      final albumData = Gallery.fromMap(data['data']);
      return albumData;
    } catch (e) {
      throw GetAlbumFailure();
    }
  }

  Future<Map<String, dynamic>> deleteAlbum(int albumId) async {
    try {
      final res = await _authRestClient.doHttpDelete(
        url: '/api/v1/staff/gallery/delete',
        requestBody: {
          'gallery_id': albumId,
        },
      );

      return res;
    } catch (e) {
      return {};
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

  Future<List<PhoneBookStudent>> getPhoneBookStudent({
    required int classId,
    required int schoolId,
    required String schoolBrand,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/class/$classId/pupils',
        headers: {
          'School-Id': schoolId,
          'School-Brand': schoolBrand,
        },
      );
      final dataList = data['data'] as List<dynamic>?;

      if (dataList == null) {
        return [];
      }

      List<PhoneBookStudent> dataPhoneBook = [];
      for (final item in dataList) {
        dataPhoneBook.add(PhoneBookStudent.fromJson(item));
      }

      return dataPhoneBook;
    } catch (e) {
      return [];
    }
  }

  Future<List<Parent>> getPhoneBookParent({
    required int classId,
    required int schoolId,
  }) async {
    try {
      final data = await _client
          .doHttpGet('/api/v1/staff/parent/class', queryParameters: {
        'class_id': classId,
        'school_id': schoolId,
      });

      final dataList = data['data']['items'] as List<dynamic>?;

      if (dataList == null) {
        return [];
      }

      List<Parent> parents = [];
      for (final item in dataList) {
        parents.add(Parent.fromMap(item as Map<String, dynamic>));
      }

      return parents;
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
        url: '/api/v1/staff/message/$idMessage/pin',
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
        url: '/api/v1/staff/message/$idMessage/un-pin',
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

  Future<ConservationDetail?> getMessagePin({
    required String schoolBrand,
    required int schoolId,
    required String recipientId,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/message/pinned',
        queryParameters: {
          'recipient_id': recipientId,
        },
        headers: {
          'School_Brand': schoolBrand,
          'School_Id': schoolId,
        },
      );
      final jsonData = data['data'] as List<dynamic>;
      return ConservationDetail.fromJson(jsonData[0]);
    } catch (e) {
      return null;
    }
  }

  Future<List<Conservation>> getlistMessage({
    required int schoolId,
    required String classId,
    required String userId,
    required String schoolBrand,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/conversations',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
        queryParameters: {
          'class_id': classId,
          'user_id': userId,
        },
      );
      final dataList = data['data']['data'] as List<dynamic>?;
      return dataList?.map((e) => Conservation.fromJson(e)).toList() ?? [];
    } catch (e) {
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
        '/api/v1/staff/class/teacher',
        headers: {
          'School-Id': schoolId,
          'School-Brand': schoolBrand,
        },
        queryParameters: {
          'teacher_id': teacherId,
          'learn_year': learnYear,
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
      final data = await _partnerTokenRestClient.doHttpGet(
        '/api.php?act=get_lesson_register',
        queryParameters: {
          'user_key': userKey,
          'txt_date': txtDate,
          'teacher_id': teacherId,
        },
        hasDelay: true,
      );

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
    required String subjectType,
  }) async {
    final data = await _client.doHttpGet(
      '/api/v1/staff/mark/get-semester?cap_dao_tao=$capDaoTao&subject_type=$subjectType',
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

  Future<Assessment> onGetAssessmentCriteria({
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

      return Assessment.fromMap(data);
    } catch (e) {
      return Assessment.empty();
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
    required File? fileBaoBai,
    required String? linkBaoBai,
    required String hanNop,
    required String userKey,
  }) async {
    var formData = FormData();

    formData.fields.add(MapEntry("user_key", userKey));
    formData.fields.add(MapEntry("lesson_id", lessionId));
    formData.fields.add(MapEntry("lesson_title", lessionTitle));
    formData.fields.add(MapEntry("lesson_note", lessionNote));
    formData.fields.add(MapEntry("tiet_ppct", tietPpct));
    formData.fields.add(MapEntry("lesson_rank", lessionRank));
    formData.fields.add(MapEntry("dan_do_bao_bai", danDoBaoBai));
    formData.fields.add(MapEntry("han_nop", hanNop));

    if (fileBaoBai != null) {
      formData.files.add(
        MapEntry(
          'file_bao_bai',
          await MultipartFile.fromFile(fileBaoBai.path),
        ),
      );
    }

    if (linkBaoBai != null) {
      formData.fields.add(MapEntry("link_bao_bai", linkBaoBai));
    }

    final data = await _partnerTokenRestClient.dio.post(
      '/api/api.php?act=weeklylesson_post_new',
      data: formData,
      options: Options(
        headers: {
          'Parter-Token':
              'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJPbmxpbmUgSldUIEJ1aWxkZXIiLCJpYXQiOjE2NTczMzE2ODgsImV4cCI6MTY4ODg2NzY4OCwiYXVkIjoid3d3LmV4YW1wbGUuY29tIiwic3ViIjoianJvY2tldEBleGFtcGxlLmNvbSIsIkdpdmVuTmFtZSI6IkpvaG5ueSIsIlN1cm5hbWUiOiJSb2NrZXQiLCJFbWFpbCI6Impyb2NrZXRAZXhhbXBsZS5jb20iLCJSb2xlIjpbIk1hbmFnZXIiLCJQcm9qZWN0IEFkbWluaXN0cmF0b3IiXX0.3PXXeua7B4UfGhvH4s8QWKCzf5w0M_uGUODs7-wXj_g',
        },
      ),
    );

    return data.data;
  }

  Future<Map<String, dynamic>> postViolation({
    required List<Map<String, dynamic>>? containerData,
  }) async {
    Map<String, dynamic> data = {};

    for (var item in containerData!) {
      final dataPost = await _partnerTokenRestClient.doHttpPost(
        url: '/api/api.php?act=post_hsvp',
        requestBody: item,
      );
      data = dataPost;
    }

    return data;
  }

  Future<ScoreProgramList> getProgramList(
      String userKey, String txtYear) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
        '/api.php',
        queryParameters: {
          'act': 'list_chuong_trinh_khac',
          'user_key': userKey,
          'txt_learn_year': txtYear,
        },
      );

      final scoreRes = ScoreProgramList.fromMap(data);
      return scoreRes;
    } catch (e) {
      throw GetAlbumFailure();
    }
  }

  Future<ListClassLeader> getClassLeader({
    required String learnyear,
    required String userKey,
  }) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
        '/api/api.php?act=list_class_gvcn&user_key=$userKey&learn_year=$learnyear',
      );
      return ListClassLeader.fromJson(data);
    } catch (e) {
      return ListClassLeader.empty();
    }
  }

  Future<ScoreModel> getMoetTypeScore(
    String userKey,
    String txtHocKy,
    String txtYear,
    String ctId,
    bool isMOET,
  ) async {
    try {
      String type = '';
      if (isMOET) {
        type = 'show_score';
      } else {
        type = 'score_chuong_trinh_khac';
      }
      final data = await _partnerTokenRestClient.doHttpGet(
        '/api.php',
        queryParameters: {
          'act': type,
          'user_key': userKey,
          'txt_learn_year': txtYear,
          'txt_hoc_ky': txtHocKy,
          if (!isMOET) 'ct_id': ctId,
        },
      );

      final scoreRes = ScoreModel.fromMap(data);
      return scoreRes;
    } catch (e) {
      throw GetScoreFailure();
    }
  }

  Future<Data> getTeachingClassMoetPrimary({
    required String subjectId,
    required String classId,
    required String semester,
    required String learnYear,
    required String schoolBrand,
    required String schoolId,
    required String capDaoTao,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/mark/primary-school/result?subject_id=$subjectId&class_id=$classId&semester=$semester&learn_year=$learnYear',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      return Data.fromJson(data['data']);
    } catch (e) {
      return Data.empty();
    }
  }

  Future<MoetHighData> getTeachingClassMoetHigh({
    required String subjectId,
    required String classId,
    required String semester,
    required String learnYear,
    required String schoolBrand,
    required String schoolId,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/mark/high-school/result?subject_id=$subjectId&class_id=$classId&semester=$semester&learn_year=$learnYear',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      return MoetHighData.fromJson(data['data']);
    } catch (e) {
      return MoetHighData.empty();
    }
  }

  Future<List<MarkTypeColumn>> getMarkType({
    required String subjectType,
    required int classId,
    required String capDaoTao,
    required String schoolBrand,
    required int schoolId,
  }) async {
    final data = await _client.doHttpGet(
      '/api/v1/staff/mark/get-score-type?subject_type=$subjectType&class_id=$classId&cap_dao_tao=$capDaoTao',
      headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
    );
    final jsonData = data['data'] as List<dynamic>;
    return jsonData.map((e) => MarkTypeColumn.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> postMoetPrimary({
    required int subjectId,
    required int classId,
    required String semester,
    required int pupilId,
    required String markType,
    required String? markValue,
    required String? markNote,
    required int schoolId,
    required String schoolBrand,
  }) async {
    final data = await _client.doHttpPost(
        url: '/api/v1/staff/mark/bulk-insert/primary-school',
        headers: {
          'School-Id': schoolId,
          'School-Brand': schoolBrand
        },
        requestBody: {
          "subject_id": subjectId,
          "class_id": classId,
          "semester": semester,
          "items": [
            {
              "pupil_id": pupilId,
              "mark_type": markType,
              "mark_coefficient": 0,
              "mark_value": int.parse(markValue ?? '0'),
              "mark_note": markNote ?? ''
            }
          ]
        });
    return data;
  }

  Future<FormMoet> getFormMoet({
    required int classId,
    required int subjectId,
    required String learnYear,
    required String semester,
    required int schoolId,
    required String schoolBrand,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/mark/form?class_id=$classId&subject_id=$subjectId&learn_year=$learnYear&semester=2',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      return FormMoet.fromJson(data['data']);
    } catch (e) {
      return FormMoet.empty();
    }
  }

  Future<MoetAverage> getMoetAverage(
    String userKey,
    String txtLearnYear,
    String txtHocKy,
  ) async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
        '/api.php',
        queryParameters: {
          'act': 'total_score_moet',
          'user_key': userKey,
          'txt_learn_year': txtLearnYear,
          'txt_hoc_ky': txtHocKy,
        },
      );

      final moetAverage = MoetAverage.fromMap(data);
      return moetAverage;
    } catch (e) {
      return MoetAverage.empty();
    }
  }

  Future<Map<String, dynamic>> postCommentMoet({
    required String userKey,
    required int pupilId,
    required int subjectId,
    required String coomentContent,
    required String learnYear,
    required String hkTihValue,
    required String schoolBrand,
    required int schoolId,
  }) async {
    try {
      final data = await _client.doHttpPost(
        url: '/api.php?act=post_comment',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
        requestBody: {
          "user_key": userKey,
          "pupil_id": pupilId,
          "subject_id": subjectId,
          "comment_content": coomentContent,
          "learn_year": learnYear,
          "hk_tih_value": hkTihValue
        },
      );
      return data;
    } catch (e) {
      throw GetAlbumFailure();
    }
  }

  Future<Map<String, dynamic>> postEslGpa({
    required int classId,
    required int semester,
    required String learnYear,
    required List<JsonDataESL> dataESL,
    required int schoolId,
    required String schoolBrand,
  }) async {
    try {
      final List<Map<String, dynamic>> newData = [];
      for (var item in dataESL) {
        newData.add(updateESL(item));
      }
      final data = await _client
          .doHttpPost(url: '/api/v1/staff/mark/bulk-insert/esl', headers: {
        'School-Id': schoolId,
        'School-Brand': schoolBrand
      }, requestBody: {
        "class_id": classId,
        "semester": semester,
        "learn_year": learnYear,
        "items": newData
      });
      return data;
    } catch (e) {
      throw GetAlbumFailure();
    }
  }

  Future<Map<String, dynamic>> postPrimaryConduct({
    required String userKey,
    required int classId,
    required String learnYear,
    required int hocKy,
    required int hocKyTih,
    required List<ConductScore> dataConduct,
  }) async {
    final data = await _partnerTokenRestClient.doHttpPost(
      url: '/api/api.php?act=post_hanhkiemtih',
      requestBody: {
        "user_key": userKey,
        "class_id": classId,
        "learn_year": learnYear,
        "hoc_ky": hocKy,
        "hoc_ky_tih": hocKyTih,
        "items": dataConduct
      },
    );
    return data;
  }

  Future<HanhKiemData> getFormConduct() async {
    try {
      final data = await _partnerTokenRestClient.doHttpGet(
        '/api/api.php?act=list_hanhkiem_key',
      );
      return HanhKiemData.fromJson(data);
    } catch (e) {
      throw GetAlbumFailure();
    }
  }

  Future<List<FormScoreESL>> getFormScoreESL({
    required int classId,
    required int subjectId,
    required String scoreType,
    required int semester,
    required String learnYear,
    required int schoolId,
    required String schoolBrand,
  }) async {
    try {
      final data = await _client.doHttpGet(
        '/api/v1/staff/mark/form-esl?class_id=$classId&subject_id=$subjectId&score_type=$scoreType&semester=$semester&learn_year=$learnYear',
        headers: {'School-Id': schoolId, 'School-Brand': schoolBrand},
      );
      final jsonData = data['data'] as List<dynamic>;
      return jsonData.map((e) => FormScoreESL.fromJson(e)).toList();
    } catch (e) {
      return FormScoreESL.fakeData();
    }
  }

  Future<Map<String, dynamic>> postScoreMoetHighSchool({
    required int schoolId,
    required int subjectId,
    required int classId,
    required String semester,
    required List<JsonDataMoet> data,
    required String schoolBrand,
  }) async {
    try {
      final List<Map<String, dynamic>> newData = [];
      for (var item in data) {
        newData.add(updateScoreMoet(item));
      }
      final res = await _client.doHttpPost(
          url: '/api/v1/staff/mark/bulk-insert/high-school',
          headers: {
            'School-Id': schoolId,
            'School-Brand': schoolBrand
          },
          requestBody: {
            "school_id": schoolId,
            "subject_id": subjectId,
            "class_id": classId,
            "semester": semester,
            "items": newData
          });
      return res;
    } catch (e) {
      throw GetAlbumFailure();
    }
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

Map<String, dynamic> updateScoreMoet(JsonDataMoet data) {
  return {
    "pupil_id": data.pupilId,
    "mark_type": data.markType,
    "mark_coefficient": data.markCoefficient,
    "mark_value": data.markValue,
    "mark_note": data.markNote
  };
}

Map<String, dynamic> updateESL(JsonDataESL data) {
  List<Map<String, dynamic>> fieldsList =
      data.fields.map((field) => updateFields(field)).toList();

  return {
    "pupil_id": data.pupilId,
    "class_id": data.classId,
    "subject_id": data.subjectId,
    "semester": data.semester,
    "learn_year": data.learnYear,
    "fields": fieldsList,
  };
}

Map<String, dynamic> updateFields(ScoreFieldESL data) {
  return {
    "id": data.id,
    "score_type": data.scoreType,
    "key": data.key,
    "input_value": data.inputValue
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

class JsonDataMoet {
  int pupilId;
  String markType;
  String markCoefficient;
  String markValue;
  String markNote;
  JsonDataMoet({
    required this.markCoefficient,
    required this.markNote,
    required this.markType,
    required this.markValue,
    required this.pupilId,
  });
}

class ConductScore {
  final int pupilId;
  final String hanhKiemKey;
  final String hanhKiemValue;

  ConductScore({
    required this.pupilId,
    required this.hanhKiemKey,
    required this.hanhKiemValue,
  });

  Map<String, dynamic> toJson() {
    return {
      'pupil_id': pupilId,
      'hanh_kiem_key': hanhKiemKey,
      'hanh_kiem_value': hanhKiemValue,
    };
  }
}

class JsonDataESL {
  final int pupilId;
  final String classId;
  final String subjectId;
  final String semester;
  final String learnYear;
  final List<ScoreFieldESL> fields;
  JsonDataESL({
    required this.classId,
    required this.fields,
    required this.learnYear,
    required this.pupilId,
    required this.semester,
    required this.subjectId,
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
