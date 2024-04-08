import 'package:network_data_source/network_data_source.dart';

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
  Future<ScoreResData> getScore({
    required String userKey,
    required String txtTerm,
    required String txtYear,
  }) async {
    try {
      final scoreData = await _appFetchApi.getScore(userKey, txtTerm, txtYear);
      return scoreData;
    } catch (e) {
      rethrow;
    }
  }

  Future<NotificationData> getNotifications(
          {required Map<String, Object> headers}) =>
      _appFetchApi.getNotifications(headers: headers);

  Future<List<LeaveData>> getLeaves(
      {required int classId,
      required int pupilId,
      required int schoolId,
      required String schoolBrand}) async {
    final data = _appFetchApi.getLeaves(
        classId: classId,
        pupilId: pupilId,
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
      required String schoolBrand}) async {
    final data = await _appFetchApi.getAttendanceDay(
        date: date,
        pupilId: pupilId,
        classId: classId,
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
    final data = await _appFetchApi.getAttendanceWeek(
        pupilId: pupilId,
        classId: classId,
        schoolId: schoolId,
        schoolBrand: schoolBrand,
        startDate: startDate,
        endDate: endDate);
        return data;
  }


  // Ex: truyền param vào và handle data trả về từ api
  // Future<ProfileInfo> login({
  //   required String userName,
  //   required String password,
  //   required bool isSaveLoginInfo,
  // }) async {
  //   try {
  //     final loginInfo =
  //         await _authApi.login(email: userName, password: password);

  //     if (isSaveLoginInfo) {
  //       await _authLocalStorage.clearLoginInfo();
  //       await _authLocalStorage.saveLoginInfo(
  //         email: userName,
  //         password: password,
  //       );
  //     }
  //     return loginInfo;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
