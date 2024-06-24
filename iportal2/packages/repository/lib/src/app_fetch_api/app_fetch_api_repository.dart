import 'package:core/core.dart';
import 'package:network_data_source/network_data_source.dart';

import '../models/bus_schedule.dart';

class AppFetchApiRepository {
  AppFetchApiRepository({
    required AppFetchApi appFetchApi,
  }) : _appFetchApi = appFetchApi;

  final AppFetchApi _appFetchApi;

  // Master data
  Future<LearnYear> getLearnYearList({required int schoolId}) =>
      _appFetchApi.getLearnYearList(schoolId);

  // Member
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

  Future<ScoreModel> getMoetTypeScore({
    required String userKey,
    required String txtHocKy,
    required String txtYear,
    required String ctId,
  }) async {
    try {
      final scoreData =
          await _appFetchApi.getMoetTypeScore(userKey, txtHocKy, txtYear, ctId);
      return scoreData;
    } catch (e) {
      rethrow;
    }
  }

  Future<MoetAverage> getMoetAverage({
    required String userKey,
    required String txtHocKy,
    required String txtYear,
  }) async {
    try {
      final moetAverage =
          await _appFetchApi.getMoetAverage(userKey, txtYear, txtHocKy);
      return moetAverage;
    } catch (e) {
      return MoetAverage.empty();
    }
  }

  Future<ScoreProgramList> getProgramList({
    required String userKey,
    required String txtYear,
  }) async {
    try {
      final programList = await _appFetchApi.getProgramList(userKey, txtYear);
      return programList;
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
    required String txtHocKy,
    required String txtYear,
  }) async {
    try {
      final scoreData =
          await _appFetchApi.getEslScore(userKey, txtHocKy, txtYear);
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
      startDate: startDate.yyyyMMdd,
    );
    return data.map((e) => BusSchedule.fromData(e)).toList();
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

  Future<List<Survey>> getSurveyList({required String capDaoTaoId}) async {
    final data = await _appFetchApi.getSurveyList(capDaoTaoId);
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

  Future<Map<String, dynamic>?> changePassword({
    required String password,
    required String currentPassword,
    required String passwordConfirmation,
  }) async {
    final data = await _appFetchApi.changePassword(
      password: password,
      currentPassword: currentPassword,
      passwordConfirmation: passwordConfirmation,
    );
    return data;
  }

  Future<Map<String, dynamic>?> turnOffNoti({
    required int pushNotify,
    required Map<String, Object> headers,
  }) async {
    final data = await _appFetchApi.turnOffNoti(
      pushNotify: pushNotify,
      headers: headers,
    );
    return data;
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

  Future<StudentFeesResponse> getListFee(
          {required String schoolBrand,
          required int schoolId,
          required int pupilId,
          required String learnYear}) async =>
      await _appFetchApi.getListFee(
        schoolBrand: schoolBrand,
        schoolId: schoolId,
        pupilId: pupilId,
        learnYear: learnYear,
      );

  Future<StudentFeesResponse> getListFeeRequested(
          {required String schoolBrand,
          required int schoolId,
          required int pupilId,
          required String learnYear}) async =>
      await _appFetchApi.getListFeeRequested(
        schoolBrand: schoolBrand,
        schoolId: schoolId,
        pupilId: pupilId,
        learnYear: learnYear,
      );

  Future<String> postFeeRequested({
    required String schoolBrand,
    required int schoolId,
    required int pupilId,
    required String learnYear,
    required List<FeeItem> listFee,
  }) async =>
      await _appFetchApi.postFeeRequested(
        schoolBrand: schoolBrand,
        schoolId: schoolId,
        pupilId: pupilId,
        learnYear: learnYear,
        listFee: listFee,
      );

  Future<SchoolFee> getSchoolFee(
          {required int pupilId, required String learnYear}) async =>
      await _appFetchApi.getSchoolFee(pupilId: pupilId, learnYear: learnYear);

  Future<HistorySchoolFee> getHistorySchoolFee(
          {required int pupilId, required String learnYear}) async =>
      await _appFetchApi.getHistorySchoolFee(
          pupilId: pupilId, learnYear: learnYear);

  Future<List<PaymentGateway>> getPaymentGateways() async =>
      await _appFetchApi.getPaymentGateway();
  Future<SchoolFeePaymentPreview> getSchoolFeePaymentPreview(
          {required int pupilId,
          required num totalMoneyPayment,
          required String learnYear}) async =>
      await _appFetchApi.getSchoolFeePaymentPreview(
          pupilId: pupilId,
          totalMoneyPayment: totalMoneyPayment,
          learnYear: learnYear);
  Future<Gateway> choosePaymentGateway(
          {required int pupilId,
          required int totalMoneyPayment,
          required int paymentId,
          required String learnYear}) async =>
      await _appFetchApi.choosePaymentGateway(
          pupilId: pupilId,
          totalMoneyPayment: totalMoneyPayment,
          paymentId: paymentId,
          learnYear: learnYear);

  Future<SchoolFeePaymentPreview> getPreviewSchooWithBalance(
          {required int pupilId,
          required int totalMoneyPayment,
          required String learnYear}) async =>
      await _appFetchApi.getPreviewSchooWithBalance(
          pupilId: pupilId,
          totalMoneyPayment: totalMoneyPayment,
          learnYear: learnYear);

  Future<bool> payWithBalance(
          {required int pupilId,
          required int totalMoneyPayment,
          required String learnYear}) async =>
      await _appFetchApi.payWithBalance(
          pupilId: pupilId,
          totalMoneyPayment: totalMoneyPayment,
          learnYear: learnYear);

  Future<List<LearnYearPayment>> getLearnYears({required int number}) async =>
      await _appFetchApi.getLearnYears(number: number);
}
