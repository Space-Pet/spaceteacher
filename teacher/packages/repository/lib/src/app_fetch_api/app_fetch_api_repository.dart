import 'dart:io';

import 'package:core/core.dart';
import 'package:core/data/models/list_attendance_bus.dart';
import 'package:core/data/models/observation_model.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';
import 'package:intl/intl.dart';

class AppFetchApiRepository {
  AppFetchApiRepository({
    required AppFetchApi appFetchApi,
  }) : _appFetchApi = appFetchApi;

  final AppFetchApi _appFetchApi;

  Future<WeeklyLessonData> getRegisterNoteBook(
          {required String userKey, required String txtDate}) =>
      _appFetchApi.getRegisterNoteBook(userKey: userKey, txtDate: txtDate);

  Future<Schedule> getSchedule(
          {required String userKey, required String txtDate}) =>
      _appFetchApi.getSchedule(userKey, txtDate);

  Future<List<ExerciseItem>> getExercises({
    required String userKey,
    required DateTime datePicked,
    bool isDueDate = true,
  }) async {
    final exerciseData = await _appFetchApi.getExercises(
      userKey,
      datePicked.ddMMyyyyDash,
      isDueDate: isDueDate,
    );

    if (!isDueDate) {
      return exerciseData.exerciseDataList;
    }

    final listExerciseDueDate = exerciseData.exerciseDataList
        .where((element) => element.hanNopBaoBai == datePicked.yyyyMMdd)
        .toList();

    return listExerciseDueDate;
  }

  Future<ScoreModel> getMoetScore({
    required String userKey,
    required String txtHocKy,
    required String txtYear,
  }) async {
    try {
      final scoreData =
          await _appFetchApi.getMoetScore(userKey, txtHocKy, txtYear);
      return scoreData;
    } catch (e) {
      rethrow;
    }
  }

  Future<PrimaryConduct> getPrimaryConduct({
    required String userKey,
    required String txtHocKy,
    required String txtYear,
    required String hkTihValue,
  }) async {
    try {
      final conductData = await _appFetchApi.getPrimaryConduct(
          userKey, txtHocKy, txtYear, hkTihValue);
      return conductData;
    } catch (e) {
      rethrow;
    }
  }

  Future<EslScore> getEslScore({
    required String userKey,
    required String txtTerm,
    required String txtYear,
  }) async {
    try {
      final scoreData =
          await _appFetchApi.getEslScore(userKey, txtTerm, txtYear);
      return scoreData;
    } catch (e) {
      rethrow;
    }
  }

  Future<NotificationData> getNotifications({
    required Map<String, Object> headers,
    required int viewed,
    required String orderBy,
  }) =>
      _appFetchApi.getNotifications(
        headers: headers,
        viewed: viewed,
        orderBy: orderBy,
      );

  Future<NotificationData> getSentNoti({
    required Map<String, Object> headers,
    required String status,
    required String orderBy,
  }) =>
      _appFetchApi.getSentNoti(
        headers: headers,
        status: status,
        orderBy: orderBy,
      );

  Future<SentNotiDetail> getNotiDetailTeacher({
    required Map<String, Object> headers,
    required int id,
  }) =>
      _appFetchApi.getNotiDetailTeacher(
        headers: headers,
        id: id,
      );

  Future<List<LeaveTeacher>> getLeavesTeacher(
      {required String status,
      required DateTime startDate,
      required int schoolId,
      required String schoolBrand}) async {
    final data = _appFetchApi.getLeavesTeacher(
        status: status,
        startDate: DateFormat('yyyy-MM-dd').format(startDate),
        schoolId: schoolId,
        schoolBrand: schoolBrand);
    return data;
  }

  Future<WeekSchedule> getWeekSchedule({
    required String userKey,
    required String txtDate,
  }) async {
    final data = await _appFetchApi.getWeekSchedule(
      userKey: userKey,
      txtDate: txtDate,
    );
    return data;
  }

  Future<List<AttendanceDay>> getAttendanceDay(
      {required String date,
      required int pupilId,
      required int classId,
      required int schoolId,
      required String type,
      required String schoolBrand}) async {
    final data = await _appFetchApi.getAttendanceDay(
        date: date,
        pupilId: pupilId,
        classId: classId,
        type: type,
        schoolId: schoolId,
        schoolBrand: schoolBrand);
    return data;
  }

  Future<AttendanceWeek> getAttendanceWeek(
      {required int pupilId,
      required int classId,
      required int schoolId,
      required String schoolBrand,
      required String startDate,
      required String endDate}) async {
    final data = await _appFetchApi.getAttendanceWeek(
        pupilId: pupilId,
        classId: classId,
        schoolId: schoolId,
        schoolBrand: schoolBrand,
        startDate: startDate,
        endDate: endDate);
    return data;
  }

  Future<AttendanceWeek> getAttendanceMonth(
      {required int pupilId,
      required int classId,
      required int schoolId,
      required String schoolBrand,
      required String startDate,
      required String endDate}) async {
    final data = await _appFetchApi.getAttendanceMonth(
        pupilId: pupilId,
        classId: classId,
        schoolId: schoolId,
        schoolBrand: schoolBrand,
        startDate: startDate,
        endDate: endDate);
    return data;
  }

  Future<AlbumData> getAlbum(String teacherId) =>
      _appFetchApi.getAlbum(teacherId);

  Future<List<String>> getListYear(int number) =>
      _appFetchApi.getListYear(number);

  Future<List<GalleryClass>> getListClass(String learnYear) =>
      _appFetchApi.getListClass(learnYear);

  Future<List<NotiClass>> getListClassNoti(
          {required String learnYear, required int teacherId}) =>
      _appFetchApi.getListClassNoti(learnYear, teacherId);

  Future<List<PupilInClass>> getPupilInClass(
          {required Map<String, dynamic> headers, required int classId}) =>
      _appFetchApi.getPupilInClass(headers, classId);

  Future<Map<String, dynamic>> createNewAlbum({
    required String learnYear,
    required int classId,
    required String galleryName,
    required List<File> listFiles,
    required int teacherId,
  }) async {
    final data = await _appFetchApi.createNewAlbum(
      classId: classId,
      learnYear: learnYear,
      galleryName: galleryName,
      listFiles: listFiles,
      teacherId: teacherId,
    );
    return data;
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
    final data = await _appFetchApi.createNewNoti(
      listPupilId: listPupilId,
      classId: classId,
      type: type,
      title: title,
      content: content,
      status: status,
      listFiles: listFiles,
      headers: headers,
    );
    return data;
  }

  Future<Menu> getMenu({
    required String userKey,
    required String date,
  }) async {
    final data = await _appFetchApi.getMenu(userKey: userKey, date: date);
    return data;
  }

  Future<List<PhoneBookStudent>> getPhoneBookStudent(
      {required int classId}) async {
    final data = await _appFetchApi.getPhoneBookStudent(classId: classId);
    return data;
  }

  Future<List<PhoneBookTeacher>> getPhoneBookTeacher(
      {required int pupilId}) async {
    final data = await _appFetchApi.getPhoneBookTeacher(pupilId: pupilId);
    return data;
  }

  Future<Map<String, dynamic>> approveLeave({
    required int pupilId,
    required String startDate,
    required String endDate,
    required int schoolId,
    required String schoolBrand,
  }) async {
    final data = await _appFetchApi.approveLeave(
      pupilId: pupilId,
      startDate: startDate,
      endDate: endDate,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
    );
    return data;
  }

  Future<Map<String, dynamic>> approveAllLeaves({
    required List<int> ids,
    required int schoolId,
    required String schoolBrand,
  }) async {
    final data = await _appFetchApi.approveAllLeaves(
      ids: ids,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
    );
    return data;
  }

  Future<Nutrition> getNutrition({required String userKey}) async {
    final data = await _appFetchApi.getNutrition(userKey: userKey);
    return data;
  }

  Future<List<BusSchedule>> getBusSchedules({
    required int pupilId,
    required int schoolId,
    required String schoolBrand,
    required DateTime startDate,
  }) async {
    final data = await _appFetchApi.getBusSchedules(
      pupilId: pupilId,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
      startDate: startDate.yyyyMMdd,
    );
    return data.map((e) => BusSchedule.fromData(e)).toList();
  }

  Future<Map<String, dynamic>?> postPinMessage({
    required String schoolBrand,
    required int schoolId,
    required int idMessage,
  }) async {
    final data = await _appFetchApi.postPinMessage(
      schoolBrand: schoolBrand,
      schoolId: schoolId,
      idMessage: idMessage,
    );
    return data;
  }

  Future<Map<String, dynamic>?> postDeletePinMessage({
    required String schoolBrand,
    required int schoolId,
    required int idMessage,
  }) async {
    final data = await _appFetchApi.postDeletePinMessage(
      schoolBrand: schoolBrand,
      schoolId: schoolId,
      idMessage: idMessage,
    );
    return data;
  }

  Future<MessageDetail?> getMessagePin({
    required String schoolBrand,
    required int schoolId,
  }) async {
    final data = await _appFetchApi.getMessagePin(
        schoolBrand: schoolBrand, schoolId: schoolId);

    return data;
  }

  Future<List<Message>> getListMessage({
    required int schoolId,
    required String classId,
    required String userId,
    required String schoolBrand,
  }) async {
    final data = await _appFetchApi.getlistMessage(
      schoolId: schoolId,
      schoolBrand: schoolBrand,
      classId: classId,
      userId: userId,
    );
    return data;
  }

  Future<Map<String, dynamic>> getMessageDetail({
    required String conversationId,
    required int schoolId,
    required String schoolBrand,
    int? page,
  }) async {
    final data = await _appFetchApi.getMessageDetail(
        conversationId: conversationId,
        schoolId: schoolId,
        schoolBrand: schoolBrand,
        page: page);
    return data;
  }

  Future<int> postMessage({
    required String content,
    required String classId,
    required String recipient,
    required int schoolId,
    required String schoolBrand,
  }) async {
    final data = await _appFetchApi.postMessage(
      content: content,
      classId: classId,
      recipient: recipient,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
    );
    return data;
  }

  Future<int> deleteMessageDetail({
    required String content,
    required int schoolId,
    required String schoolBrand,
    required String recipient,
    required int idMessage,
  }) async {
    final data = await _appFetchApi.deleteMessageDetail(
        content: content,
        schoolId: schoolId,
        schoolBrand: schoolBrand,
        recipient: recipient,
        idMessage: idMessage);
    return data;
  }

  Future<int> deleteMessage({
    required int schoolId,
    required String schoolBrand,
    required int idMessage,
  }) async {
    final data = await _appFetchApi.deleteMessage(
      schoolId: schoolId,
      schoolBrand: schoolBrand,
      idMessage: idMessage,
    );
    return data;
  }

  Future<List<Comment>> getComment(
      {required String userKey, required String txtDate, required}) async {
    final data =
        await _appFetchApi.getComment(userKey: userKey, txtDate: txtDate);
    return data;
  }

  Future<List<ListReportStudent>> getListReportStudent(
      {required int pupilId,
      required int semester,
      required int schoolId,
      required String schoolBrand,
      required String learnYear}) async {
    final data = await _appFetchApi.getListReportStudent(
        pupilId: pupilId,
        schoolId: schoolId,
        schoolBrand: schoolBrand,
        semester: semester,
        learnYear: learnYear);
    return data;
  }

  Future<ReportStudent> getReportStudent(
      {required int id,
      required int pupilId,
      required int schoolId,
      required String schoolBrand}) async {
    final data = await _appFetchApi.getReportStudent(
        id: id, pupilId: pupilId, schoolId: schoolId, schoolBrand: schoolBrand);
    return data;
  }

  Future<List<Survey>> getSurveyList() async {
    final data = await _appFetchApi.getSurveyList();
    return data;
  }

  Future<SurveyDetail> getSurveyDetail(int khaoSatId) async {
    final data = await _appFetchApi.getSurveyDetail(khaoSatId);
    return data;
  }

  Future<void> postSurvey({
    required List<Map<String, dynamic>> listSurvey,
    required int khaoSatId,
  }) async {
    _appFetchApi.postSurvey(
      listSurvey: listSurvey,
      khaoSatId: khaoSatId,
    );
  }

  Future<String> getAttendanceType(
      {required int schoolId, required String schoolBrand}) async {
    final data = await _appFetchApi.getAttendanceType(
        schoolId: schoolId, schoolBrand: schoolBrand);
    return data;
  }

  Future<List<ClassTeacher>> getListClassTeacher(
      {required int teacherId,
      required int schoolId,
      required String schoolBrand}) async {
    final data = await _appFetchApi.getListClassTeacher(
      teacherId: teacherId,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
    );
    return data;
  }

  Future<AttendanceWeek> getAttendanceWeekTeacher({
    required int classId,
    required String startDate,
    required String endDate,
    required int schoolId,
    required String schoolBrand,
  }) async {
    final data = await _appFetchApi.getAttendanceWeekTeacher(
      classId: classId,
      startDate: startDate,
      endDate: endDate,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
    );
    return data;
  }

  Future<List<AttendanceTeacher>> getAttendanceClassTeacher({
    required String date,
    required int schoolId,
    required String schoolBrand,
  }) async {
    final data = await _appFetchApi.getAttendanceClassTeacher(
      date: date,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
    );
    return data;
  }

  Future<List<AttendanceTeacher>> getAttendanceClassLeader({
    required String date,
    required int schoolId,
    required String schoolBrand,
  }) async {
    final data = await _appFetchApi.getAttendanceClassLeader(
      date: date,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
    );
    return data;
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
    final data = await _appFetchApi.getListAttendance(
      classId: classId,
      numberOfClassPeriod: numberOfClassPeriod,
      subjectId: subjectId,
      date: date,
      type: type,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
    );
    return data;
  }

  Future<Map<String, dynamic>?> postAttendance({
    required String type,
    required int numberOfClasspriod,
    required int classId,
    required int subject,
    required int roomId,
    required String roomTitle,
    required String date,
    required String schoolBrand,
    required int schoolId,
    required List<AttendanceDataList> attendanceData,
  }) async {
    final data = await _appFetchApi.postAttendance(
      type: type,
      numberOfClasspriod: numberOfClasspriod,
      classId: classId,
      subject: subject,
      roomId: roomId,
      roomTitle: roomTitle,
      date: date,
      schoolBrand: schoolBrand,
      schoolId: schoolId,
      attendanceData: attendanceData,
    );
    return data;
  }

  Future<Map<String, dynamic>> postTakeAttendanceOfEachStudent({
    required int schoolId,
    required String schoolBrand,
    required int pupilId,
    required String type,
    required int attendanceId,
    required int scheduleId,
  }) async {
    final data = await _appFetchApi.postTakeAttendanceOfEachStudent(
      schoolId: schoolId,
      schoolBrand: schoolBrand,
      pupilId: pupilId,
      type: type,
      attendanceId: attendanceId,
      scheduleId: scheduleId,
    );
    return data;
  }

  Future<List<ListAttendanceBus>> getListAttendanceBus({
    required int schoolId,
    required String schoolBrand,
    required int busId,
  }) async {
    final data = await _appFetchApi.getListAttendanceBus(
      schoolId: schoolId,
      schoolBrand: schoolBrand,
      busId: busId,
    );
    return data;
  }

  Future<DetailBusSchedule> getDetailBusSchedule({
    required int schoolId,
    required String schoolBrand,
    required int idBus,
  }) async {
    final data = await _appFetchApi.getDetailBusSchedule(
      schoolBrand: schoolBrand,
      schoolId: schoolId,
      idBus: idBus,
    );
    return data;
  }

  Future<List<BusScheduleTeacher>> getBusScheduleTeacher({
    required String startDate,
    required String endDate,
    required String schoolBrand,
    required int schoolId,
  }) async {
    final data = await _appFetchApi.getBusScheduleTeacher(
      startDate: startDate,
      endDate: endDate,
      schoolBrand: schoolBrand,
      schoolId: schoolId,
    );
    return data;
  }

  Future<Map<String, dynamic>> postUpdateAbsentBus({
    required int schoolId,
    required String schoolBrand,
    required int pupilId,
    required int attendanceId,
    required int scheduleId,
  }) async {
    final data = await _appFetchApi.postUpdateAbsentBus(
      schoolId: schoolId,
      schoolBrand: schoolBrand,
      pupilId: pupilId,
      attendanceId: attendanceId,
      scheduleId: scheduleId,
    );
    return data;
  }

  Future<Map<String, dynamic>?> turnOffNoti({
    required bool pushNotify,
    required Map<String, Object> headers,
  }) async {
    final data = await _appFetchApi.turnOffNoti(
      pushNotify: pushNotify,
      headers: headers,
    );
    return data;
  }

  Future<List<Pupils>> getEditAttendanceBus({
    required int schoolId,
    required String schoolBrand,
    required int busId,
  }) async {
    final data = await _appFetchApi.getEditAttendanceBus(
      schoolId: schoolId,
      schoolBrand: schoolBrand,
      busId: busId,
    );
    return data;
  }

  Future<Map<String, dynamic>> postEditAttendanceBus({
    required String type,
    required int schedule,
    required List<Map<String, dynamic>> listEdit,
  }) async {
    final data = await _appFetchApi.postEditAttendanceBus(
      type: type,
      schedule: schedule,
      listEdit: listEdit,
    );
    return data;
  }

  Future<Map<String, dynamic>> getTeacherListBySchool({
    required int schoolId,
  }) async {
    final response = await _appFetchApi.getTeacherListBySchool(
      schoolId: schoolId,
    );

    return response;
  }

  Future<Map<String, dynamic>> getLessonRegister({
    required String userKey,
    required String txtDate,
    required int schoolId,
    int? teacherId,
  }) async {
    final response = await _appFetchApi.getLessonRegister(
      userKey: userKey,
      txtDate: txtDate,
      schoolId: schoolId,
      teacherId: teacherId,
    );

    return response;
  }

  Future<Map<String, dynamic>> getTeacherListByTeacherId({
    required int teacherId,
  }) async {
    final response = await _appFetchApi.getTeacherListByTeacherId(
      teacherId: teacherId,
    );

    return response;
  }

  Future<Map<String, dynamic>> getListSubject({
    required int schoolId,
  }) async {
    final response = await _appFetchApi.getListSubject(
      schoolId: schoolId,
    );

    return response;
  }

  Future<Map<String, dynamic>> getListClassBySchoolId({
    required int schoolId,
    required String learnYear,
  }) async {
    final response = await _appFetchApi.getListClassBySchool(
      schoolId: schoolId,
      learnYear: learnYear,
    );

    return response;
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
    final response = await _appFetchApi.postLessonRegister(
      userKey: userKey,
      txtDate: txtDate,
      schoolId: schoolId,
      teacherId: teacherId,
      tietNum: tietNum,
      classId: classId,
      subjectId: subjectId,
    );

    return response;
  }
}
