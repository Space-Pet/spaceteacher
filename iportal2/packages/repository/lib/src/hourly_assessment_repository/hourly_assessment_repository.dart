import 'package:core/data/models/models.dart';
import 'package:network_data_source/network_data_source.dart';

class HourlyAssessmentRepository {
  HourlyAssessmentRepository({
    required HourlyAssessmentApi hourlyAssessmentApi,
  }) : _hourlyAssessmentApi = hourlyAssessmentApi;
  final HourlyAssessmentApi _hourlyAssessmentApi;

  Future<RegisterHourlyAssessment> createHourlyAssessment({
    required String userKey,
    required int teacherId,
    required int classId,
    required int subjectId,
    required int schoolId,
    required String date,
    required int tietNum,
  }) =>
      _hourlyAssessmentApi.createHourlyAssessment(
        userKey: userKey,
        teacherId: teacherId,
        classId: classId,
        subjectId: subjectId,
        schoolId: schoolId,
        date: date,
        tietNum: tietNum,
      );

  Future<UpdateHourlyAssessment> updateHourlyAssessment({
    required String userKey,
    required int lessonRegisterId,
    required String noteId,
    required int diemDat,
    required int tieuChiDiem,
    required String nhanXet,
  }) =>
      _hourlyAssessmentApi.updateHourlyAssessment(
        userKey: userKey,
        lessonRegisterId: lessonRegisterId,
        noteId: noteId,
        diemDat: diemDat,
        tieuChiDiem: tieuChiDiem,
        nhanXet: nhanXet,
      );

  Future<HourlyAssessment> getObservationSchedule({
    required String userKey,
    required int classId,
    required String dateFrom,
    required String dateTo,
  }) =>
      _hourlyAssessmentApi.getObservationSchedule(
        userKey: userKey,
        classId: classId,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );

  Future<List<HourlyAssessmentDetail>> getListHourlyAssessmentDetail({
    required String userKey,
    required int schoolId,
    required String date,
    required int teacherId,
  }) =>
      _hourlyAssessmentApi.getListHourlyAssessmentDetail(
        userKey: userKey,
        schoolId: schoolId,
        date: date,
        teacherId: teacherId,
      );

  Future<void> getEvaluateEnglishHourlyAssessment({
    required String userKey,
    required int lessonRegisterId,
  }) =>
      _hourlyAssessmentApi.getEvaluateEnglishHourlyAssessment(
        userKey: userKey,
        lessonRegisterId: lessonRegisterId,
      );
  Future<void> getEvaluateMOETHourlyAssessment({
    required String userKey,
    required int lessonRegisterId,
  }) =>
      _hourlyAssessmentApi.getEvaluateMOETHourlyAssessment(
        userKey: userKey,
        lessonRegisterId: lessonRegisterId,
      );

  Future<StatusHourlyAssessment> deleteHourlyAssessment({
    required String userKey,
    required int lessonRegisterId,
  }) =>
      _hourlyAssessmentApi.deleteHourlyAssessment(
        userKey: userKey,
        lessonRegisterId: lessonRegisterId,
      );
}
