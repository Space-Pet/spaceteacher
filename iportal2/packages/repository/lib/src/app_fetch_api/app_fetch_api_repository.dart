import 'package:core/data/models/models.dart';
import 'package:intl/intl.dart';
import 'package:network_data_source/network_data_source.dart';

import '../models/bus_schedule.dart';

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

  Future<ExerciseData> getExercises({
    required String userKey,
    required String txtDate,
    bool isDueDate = true,
  }) =>
      _appFetchApi.getExercises(
        userKey,
        txtDate,
        isDueDate: isDueDate,
      );

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

  Future<NotificationItem> getNotiDetail({
    required Map<String, Object> headers,
    required int id,
  }) =>
      _appFetchApi.getNotiDetail(
        headers: headers,
        id: id,
      );

  Future<List<LeaveData>> getLeaves(
      {required int classId,
      required int pupilId,
      required int schoolId,
      required int page,
      required String schoolBrand}) async {
    final data = _appFetchApi.getLeaves(
        classId: classId,
        pupilId: pupilId,
        schoolId: schoolId,
        page: page,
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

  Future<AlbumData> getAlbum({required String pupilId}) =>
      _appFetchApi.getAlbum(pupilId: pupilId);

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

  Future<Map<String, dynamic>> postLeave({
    String? content,
    required int pupilId,
    required String startDate,
    required String endDate,
    required int leaveType,
    required int schoolId,
    required String schoolBrand,
  }) async {
    final data = await _appFetchApi.postLeave(
        content: content,
        pupilId: pupilId,
        startDate: startDate,
        endDate: endDate,
        leaveType: leaveType,
        schoolId: schoolId,
        schoolBrand: schoolBrand);
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
      startDate: DateFormat('yyyy-MM-dd').format(startDate),
    );
    return data.map((e) => BusSchedule.fromData(e)).toList();
  }

  Future<List<Message>> getListMessage(
      {required int page,
      required int schoolId,
      required String schoolBrand}) async {
    final data = await _appFetchApi.getlistMessage(
        page: page, schoolId: schoolId, schoolBrand: schoolBrand);
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

  Future<List<SurveyData>> getSurvay() async {
    final data = await _appFetchApi.getSurvay();
    return data;
  }

  Future<void> postSurvey(
      {required List<Map<String, dynamic>> listSurvey}) async {
    _appFetchApi.postSurvey(listSurvey: listSurvey);
  }

  Future<String> getAttendanceType(
      {required int schoolId, required String schoolBrand}) async {
    final data = await _appFetchApi.getAttendanceType(
        schoolId: schoolId, schoolBrand: schoolBrand);
    return data;
  }
}
