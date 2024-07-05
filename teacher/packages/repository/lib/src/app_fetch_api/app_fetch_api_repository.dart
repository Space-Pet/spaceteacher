import 'dart:io';

import 'package:core/core.dart';
import 'package:core/data/models/list_attendance_bus.dart';
import 'package:core/data/models/observation_model.dart';
import 'package:intl/intl.dart';
import 'package:network_data_source/network_data_source.dart';

class AppFetchApiRepository {
  AppFetchApiRepository({
    required AppFetchApi appFetchApi,
  }) : _appFetchApi = appFetchApi;

  final AppFetchApi _appFetchApi;

  Future<WeeklyLessonData> getRegisterNoteBook({
    required String userKey,
    required String txtDate,
    required int classSelect,
  }) =>
      _appFetchApi.getRegisterNoteBook(
        userKey: userKey,
        txtDate: txtDate,
        classSelect: classSelect,
      );

  Future<Schedule> getSchedule(
          {required String userKey,
          required String txtDate,
          required int classType}) =>
      _appFetchApi.getSchedule(userKey, txtDate, classType);

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

  Future<Map<String, dynamic>> deleteNoti({
    required int id,
  }) =>
      _appFetchApi.deleteNoti(id: id);

  Future<Map<String, dynamic>> deleteNotiFile({
    required int notificationId,
    required int attachmentId,
  }) =>
      _appFetchApi.deleteNotiFile(
        notificationId: notificationId,
        attachmentId: attachmentId,
      );

  Future<Map<String, dynamic>> deleteImagesInGallery({
    required int galleryId,
    required List<int> listId,
  }) =>
      _appFetchApi.deleteImagesInGallery(
        galleryId: galleryId,
        listId: listId,
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

  Future<Gallery> getGalleryDetail(String teacherId, int galleryId) =>
      _appFetchApi.getGalleryDetail(teacherId, galleryId);

  Future<Map<String, dynamic>> deleteAlbum(int albumId) =>
      _appFetchApi.deleteAlbum(albumId);

  Future<List<String>> getListYear(int number) =>
      _appFetchApi.getListYear(number);

  Future<List<GalleryClass>> getListClass(String learnYear) =>
      _appFetchApi.getListClass(learnYear);

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

  Future<Map<String, dynamic>> updateGallery({
    required String learnYear,
    required int classId,
    required String galleryName,
    required List<File> listFiles,
    required int galleryId,
  }) async {
    final data = await _appFetchApi.updateGallery(
      classId: classId,
      learnYear: learnYear,
      galleryName: galleryName,
      listFiles: listFiles,
      galleryId: galleryId,
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
    final data = await _appFetchApi.updateDraftNoti(
      id: id,
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
      {required int classId,
      required int schoolId,
      required String schoolBrand}) async {
    final data = await _appFetchApi.getPhoneBookStudent(
      classId: classId,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
    );
    return data;
  }

  Future<List<Parent>> getPhoneBookParent({
    required int classId,
    required int schoolId,
  }) async {
    final parents = await _appFetchApi.getPhoneBookParent(
      classId: classId,
      schoolId: schoolId,
    );
    return parents;
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

  Future<List<BusScheduleData>> getBusSchedules({
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

  Future<ConservationDetail?> getMessagePin({
    required String schoolBrand,
    required int schoolId,
    required String recipientId,
  }) async {
    final data = await _appFetchApi.getMessagePin(
      schoolBrand: schoolBrand,
      schoolId: schoolId,
      recipientId: recipientId,
    );
    return data;
  }

  Future<List<Conservation>> getListMessage({
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
    String? conversationId,
    String? recipientId,
    isGetById = false,
    required int schoolId,
    required String schoolBrand,
    required int page,
  }) async {
    final data = await _appFetchApi.getMessageDetail(
      conversationId: conversationId,
      recipientId: recipientId,
      isGetById: isGetById,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
      page: page,
    );
    return data;
  }

  Future<int> postMessage({
    required String content,
    required String classId,
    required String recipient,
    required int schoolId,
    required String schoolBrand,
    required List<File> files,
  }) async {
    final data = await _appFetchApi.postMessage(
      content: content,
      classId: classId,
      recipient: recipient,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
      files: files,
    );
    return data;
  }

  Future<int> deleteConservation({
    required int schoolId,
    required String schoolBrand,
    required int conservationId,
  }) async {
    final data = await _appFetchApi.deleteConservation(
      schoolId: schoolId,
      schoolBrand: schoolBrand,
      conservationId: conservationId,
    );
    return data;
  }

  Future<Map<String, dynamic>> deleteMessage({
    required String content,
    required int schoolId,
    required String schoolBrand,
    required String recipient,
    required int idMessage,
  }) async {
    final data = await _appFetchApi.deleteMessage(
        content: content,
        schoolId: schoolId,
        schoolBrand: schoolBrand,
        recipient: recipient,
        idMessage: idMessage);
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
    required int pushNotify,
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

  Future<List<TeacherItem>> getTeacherListBySchool({
    required int schoolId,
  }) =>
      _appFetchApi.getTeacherListBySchool(schoolId: schoolId);

  Future<List<ObservationData>> getLessonRegister({
    required String userKey,
    required String txtDate,
    required int schoolId,
    required String teacherId,
  }) =>
      _appFetchApi.getLessonRegister(
        userKey: userKey,
        txtDate: txtDate,
        schoolId: schoolId,
        teacherId: teacherId,
      );

  Future<List<RegisteredLesson>> getLessonRegistered({
    required String userKey,
    required String txtDate,
  }) =>
      _appFetchApi.getLessonRegistered(
        userKey: userKey,
        txtDate: txtDate,
      );

  Future<Map<String, dynamic>> getTeacherListByTeacherId({
    required int teacherId,
  }) async {
    final response = await _appFetchApi.getTeacherListByTeacherId(
      teacherId: teacherId,
    );

    return response;
  }

  Future<List<Semester>> getSemester({
    required int schoolId,
    required String schoolBrand,
    required String capDaoTao,
    required String subjectType,
  }) async {
    final data = await _appFetchApi.getSemester(
        schoolId: schoolId,
        schoolBrand: schoolBrand,
        capDaoTao: capDaoTao,
        subjectType: subjectType);
    return data;
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

  Future<List<ClassScore>> getListClassScore(
      {required int schoolId,
      required String schoolBrand,
      required String learnYear}) async {
    final data = await _appFetchApi.getListClassScore(
      schoolId: schoolId,
      schoolBrand: schoolBrand,
      learnYear: learnYear,
    );
    return data;
  }

  Future<FormInputScore> getFormInputScore({
    required int schoolId,
    required String schoolBrand,
    required int classId,
    required int subjectId,
    required String learnYear,
    required int semester,
  }) async {
    final data = await _appFetchApi.getFormInputScore(
      schoolId: schoolId,
      schoolBrand: schoolBrand,
      classId: classId,
      subjectId: subjectId,
      learnYear: learnYear,
      semester: semester,
    );
    return data;
  }

  Future<Map<String, dynamic>> postLessonRegister({
    required String userKey,
    required String txtDate,
    required int schoolId,
    required int teacherId,
    required int tietNum,
    required int classId,
    required int subjectId,
  }) =>
      _appFetchApi.postLessonRegister(
        userKey: userKey,
        txtDate: txtDate,
        schoolId: schoolId,
        teacherId: teacherId,
        tietNum: tietNum,
        classId: classId,
        subjectId: subjectId,
      );

  Future<Map<String, dynamic>> deleteLessonRegistered({
    required String userKey,
    required String lessonRegisterId,
  }) =>
      _appFetchApi.deleteLessonRegistered(
        userKey: userKey,
        lessonRegisterId: lessonRegisterId,
      );

  Future<Assessment> onGetAssessmentCriteria({
    required String userKey,
    required String lessonRegisterId,
    required String lessonRegisterIdType,
  }) async =>
      _appFetchApi.onGetAssessmentCriteria(
        userKey: userKey,
        lessonRegisterId: lessonRegisterId,
        lessonRegisterIdType: lessonRegisterIdType,
      );

  Future<Map<String, dynamic>?> updateMoetEvaluation(
          Map<String, dynamic> body) async =>
      _appFetchApi.updateMoetEvaluation(body);

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
    final data = await _appFetchApi.postNutritionHealth(
      pupilId: pupilId,
      learnYear: learnYear,
      txtMonth: txtMonth,
      typeHeight: typeHeight,
      weight: weight,
      height: height,
      bmi: bmi,
      distribute: distribute,
    );
    return data;
  }

  Future<List<Armorial>> getArmorial() async {
    final data = await _appFetchApi.getArmorial();
    return data;
  }

  Future<Map<String, dynamic>> postScoreComment({
    required String userKey,
    required int pupilId,
    required String weekDay,
    required String commentMnContent,
    required String huyHieuId,
    required String commentMnTitle,
  }) async {
    final data = await _appFetchApi.postScoreComment(
      userKey: userKey,
      pupilId: pupilId,
      weekDay: weekDay,
      commentMnContent: commentMnContent,
      huyHieuId: huyHieuId,
      commentMnTitle: commentMnTitle,
    );
    return data;
  }

  Future<List<ListAllForm>> getListAllForm({
    required int schoolId,
    required String schoolBrand,
  }) async {
    final data = await _appFetchApi.getListAllForm(
      schoolBrand: schoolBrand,
      schoolId: schoolId,
    );
    return data;
  }

  Future<List<ListStudentFormReport>> getListStudentFormReport({
    required int id,
    required int classId,
    required String schoolBrand,
    required int schoolId,
  }) async {
    final data = await _appFetchApi.getListStudentFormReport(
      id: id,
      classId: classId,
      schoolBrand: schoolBrand,
      schoolId: schoolId,
    );
    return data;
  }

  Future<FormDetail> getFormDetail({
    required int id,
    required int pupilId,
    required String schoolBrand,
    required int schoolId,
  }) async {
    final data = await _appFetchApi.getFormDetail(
      id: id,
      pupilId: pupilId,
      schoolBrand: schoolBrand,
      schoolId: schoolId,
    );
    return data;
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
    final data = await _appFetchApi.postUpdateReportTeacher(
      pupilId: pupilId,
      evaluationFormId: evaluationFormId,
      commentText: commentText,
      teacherEvaluation: teacherEvaluation,
      classId: classId,
      updateReport: updateReport,
      schoolBrand: schoolBrand,
      schoolId: schoolId,
    );
    return data;
  }

  Future<ViolationData> getViolationData({
    required String userKey,
    required String classId,
  }) async {
    final data = await _appFetchApi.getViolationData(
      userKey: userKey,
      classId: classId,
    );
    return data;
  }

  Future<List<ListViolation>> getListViolation() async {
    final data = await _appFetchApi.getListViolation();
    return data;
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
    final data = await _appFetchApi.postRegisterBook(
      lessionId: lessionId,
      lessionTitle: lessionTitle,
      lessionNote: lessionNote,
      tietPpct: tietPpct,
      lessionRank: lessionRank,
      danDoBaoBai: danDoBaoBai,
      fileBaoBai: fileBaoBai,
      linkBaoBai: linkBaoBai,
      userKey: userKey,
      hanNop: hanNop,
    );
    return data;
  }

  Future<Map<String, dynamic>> postViolation({
    required List<Map<String, dynamic>>? containerData,
  }) async {
    final data = await _appFetchApi.postViolation(
      containerData: containerData,
    );
    return data;
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

  Future<ListClassLeader> getClassLeader({
    required String learnYear,
    required String userKey,
  }) async {
    final data = await _appFetchApi.getClassLeader(
        learnyear: learnYear, userKey: userKey);
    return data;
  }

  Future<ScoreModel> getMoetTypeScore({
    required String userKey,
    required String txtHocKy,
    required String txtYear,
    required String ctId,
    required bool isMOET,
  }) async {
    try {
      final scoreData = await _appFetchApi.getMoetTypeScore(
          userKey, txtHocKy, txtYear, ctId, isMOET);
      return scoreData;
    } catch (e) {
      rethrow;
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
    final data = await _appFetchApi.getTeachingClassMoetPrimary(
        subjectId: subjectId,
        classId: classId,
        semester: semester,
        learnYear: learnYear,
        schoolBrand: schoolBrand,
        schoolId: schoolId,
        capDaoTao: capDaoTao);
    return data;
  }

  Future<MoetHighData> getTeachingClassMoetHigh({
    required String subjectId,
    required String classId,
    required String semester,
    required String learnYear,
    required String schoolBrand,
    required String schoolId,
  }) async {
    final data = await _appFetchApi.getTeachingClassMoetHigh(
      subjectId: subjectId,
      classId: classId,
      semester: semester,
      learnYear: learnYear,
      schoolBrand: schoolBrand,
      schoolId: schoolId,
    );
    return data;
  }

  Future<List<MarkTypeColumn>> getMarkType({
    required String subjectType,
    required int classId,
    required String capDaoTao,
    required String schoolBrand,
    required int schoolId,
  }) async {
    final data = await _appFetchApi.getMarkType(
      subjectType: subjectType,
      classId: classId,
      capDaoTao: capDaoTao,
      schoolBrand: schoolBrand,
      schoolId: schoolId,
    );
    return data;
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
    final data = await _appFetchApi.postMoetPrimary(
      subjectId: subjectId,
      classId: classId,
      semester: semester,
      pupilId: pupilId,
      markType: markType,
      markValue: markValue,
      markNote: markNote,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
    );
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
    final data = await _appFetchApi.getFormMoet(
      classId: classId,
      subjectId: subjectId,
      learnYear: learnYear,
      semester: semester,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
    );
    return data;
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
    final data = await _appFetchApi.postCommentMoet(
      userKey: userKey,
      pupilId: pupilId,
      subjectId: subjectId,
      coomentContent: coomentContent,
      learnYear: learnYear,
      hkTihValue: hkTihValue,
      schoolBrand: schoolBrand,
      schoolId: schoolId,
    );
    return data;
  }
    Future<LearnYear> getLearnYearList(int schoolId) async {
    final data = await _appFetchApi.getLearnYearList(schoolId);
    return data;
  }
   Future<Map<String, dynamic>> postEslGpa({
    required int classId,
    required int semester,
    required String learnYear,
    required List<JsonDataESL> dataESL,
    required int schoolId,
    required String schoolBrand,
  }) async {
    final data = await _appFetchApi.postEslGpa(
      classId: classId,
      semester: semester,
      learnYear: learnYear,
      dataESL: dataESL,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
    );
    return data;
  }
  Future<Map<String, dynamic>> postPrimaryConduct({
    required String userKey,
    required int classId,
    required String learnYear,
    required int hocKy,
    required int hocKyTih,
    required List<ConductScore> dataConduct,
  }) async {
    final data = await _appFetchApi.postPrimaryConduct(
      userKey: userKey,
      classId: classId,
      learnYear: learnYear,
      hocKy: hocKy,
      hocKyTih: hocKyTih,
      dataConduct: dataConduct,
    );
    return data;
  }
    Future<HanhKiemData> getFormConduct() async {
    final data = await _appFetchApi.getFormConduct();
    return data;
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
    final data = await _appFetchApi.getFormScoreESL(
      classId: classId,
      subjectId: subjectId,
      scoreType: scoreType,
      semester: semester,
      learnYear: learnYear,
      schoolId: schoolId,
      schoolBrand: schoolBrand,
    );
    return data;
  }
  Future<Map<String, dynamic>> postScoreMoetHighSchool({
    required int schoolId,
    required int subjectId,
    required int classId,
    required String semester,
    required List<JsonDataMoet> data,
    required String schoolBrand,
  }) async {
    final res = await _appFetchApi.postScoreMoetHighSchool(
      schoolId: schoolId,
      subjectId: subjectId,
      classId: classId,
      semester: semester,
      data: data,
      schoolBrand: schoolBrand,
    );
    return res;
  }
}
