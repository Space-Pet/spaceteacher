import 'package:core/data/models/hourly_assessment.dart';
import 'package:core/data/models/hourly_assessment_detail.dart';
import 'package:core/data/models/register_hourly_assessment.dart';
import 'package:core/data/models/status_hourly_assessment.dart';
import 'package:core/data/models/update_hourly_assessment.dart';

abstract class AbstractHourlyAssessmentApi {
  Future<RegisterHourlyAssessment> createHourlyAssessment({
    required String userKey,
    required int teacherId,
    required int classId,
    required int subjectId,
    required int schoolId,
    required String date,
    required int tietNum,
  });
  Future<UpdateHourlyAssessment> updateHourlyAssessment({
    required String userKey,
    required int lessonRegisterId,
    required String noteId,
    required int diemDat,
    required int tieuChiDiem,
    required String nhanXet,
  });
  Future<HourlyAssessment> getObservationSchedule({
    required String userKey,
    required int classId,
    required String dateFrom,
    required String dateTo,
  });

  Future<List<HourlyAssessmentDetail>> getListHourlyAssessmentDetail({
    required String userKey,
    required int schoolId,
    required String date,
    required int teacherId,
  });

  Future<void> getEvaluateEnglishHourlyAssessment({
    required String userKey,
    required int lessonRegisterId,
  });
  Future<void> getEvaluateMOETHourlyAssessment({
    required String userKey,
    required int lessonRegisterId,
  });

  Future<StatusHourlyAssessment> deleteHourlyAssessment({
    required String userKey,
    required int lessonRegisterId,
  });
}
