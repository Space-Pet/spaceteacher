import 'package:core/core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teacher/model/hourly_assessment_detail_model.dart';
import 'package:teacher/model/hourly_assessment_model.dart';
import 'package:teacher/model/register_hourly_assessment_model.dart';
import 'package:teacher/model/status_hourly_assessment_response_model.dart';
import 'package:teacher/model/updated_hourly_assessment.dart';
import 'package:teacher/src/services/network_services/api_path.dart';

abstract class ObservationRepository {
  Future<RegisterHourlyAssessmentModel> createHourlyAssessment({
    required String userKey,
    required int teacherId,
    required int classId,
    required int subjectId,
    required int schoolId,
    required String date,
    required int tietNum,
  });
  Future<UpdateHourlyAssessmentModel> updateHourlyAssessment({
    required String userKey,
    required int lessonRegisterId,
    required String noteId,
    required int diemDat,
    required int tieuChiDiem,
    required String nhanXet,
  });
  Future<HourlyAssessmentModel> getObservationSchedule({
    required String userKey,
    required int classId,
    required String dateFrom,
    required String dateTo,
  });

  Future<List<HourlyAssessmentDetailModel>> getListHourlyAssessmentDetail({
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

  Future<StatusHourlyAssessmentModel> deleteHourlyAssessment({
    required String userKey,
    required int lessonRegisterId,
  });
}

class ObservationRepositoryImpl implements ObservationRepository {
  @override
  Future<RegisterHourlyAssessmentModel> createHourlyAssessment({
    required String userKey,
    required int teacherId,
    required int classId,
    required int subjectId,
    required int schoolId,
    required String date,
    required int tietNum,
  }) async {
    final String token = dotenv.env['PARTNER_TOKEN'] ?? "";
    final res = await ApiClient(
      ApiPath.hourlyAssessment,
      headers: {
        'Partner-Token': token,
      },
    ).post(
      {
        "user_key": userKey,
        "txt_date": date,
        "SCHOOL_ID": schoolId,
        "TEACHER_ID": teacherId,
        "TIET_NUM": tietNum,
        "CLASS_ID": classId,
        "SUBJECT_ID": subjectId,
      },
      {
        'act': 'post_lesson_register_note',
      },
    );
    if (isNullOrEmpty(res)) return RegisterHourlyAssessmentModel();
    return RegisterHourlyAssessmentModel.fromJson(res);
  }

  @override
  Future<UpdateHourlyAssessmentModel> updateHourlyAssessment(
      {required String userKey,
      required int lessonRegisterId,
      required String noteId,
      required int diemDat,
      required int tieuChiDiem,
      required String nhanXet}) async {
    final String token = dotenv.env['PARTNER_TOKEN'] ?? "";
    final res = await ApiClient(
      ApiPath.hourlyAssessment,
      headers: {
        'Partner-Token': token,
      },
    ).post(
      {
        "lesson_register_id": lessonRegisterId,
        "user_key": userKey,
        "NOTE_ID": noteId,
        "diem_dat": diemDat,
        "tieu_chi_diem": tieuChiDiem,
        "nhan_xet": nhanXet,
      },
      {
        'act': 'post_lesson_register_note',
      },
    );
    if (isNullOrEmpty(res)) return UpdateHourlyAssessmentModel();
    return UpdateHourlyAssessmentModel.fromJson(res);
  }

  // Danh sach dang ky du gio
  @override
  Future<HourlyAssessmentModel> getObservationSchedule(
      {required String userKey,
      required int classId,
      required String dateFrom,
      required String dateTo}) async {
    final String token = dotenv.env['PARTNER_TOKEN'] ?? "";
    final res = await ApiClient(
      ApiPath.hourlyAssessment,
      headers: {
        'Partner-Token': token,
      },
    ).get(
      {
        'act': 'lesson_register',
        "user_key": userKey,
        "date_from": dateFrom,
        "date_to": dateTo,
        "class_id": classId,
      },
    );
    if (isNullOrEmpty(res)) return HourlyAssessmentModel();
    return HourlyAssessmentModel.fromJson(res);
  }

  // Tra cuu tiet du gio
  @override
  Future<List<HourlyAssessmentDetailModel>> getListHourlyAssessmentDetail(
      {required String userKey,
      required int schoolId,
      required String date,
      required int teacherId}) async {
    final String token = dotenv.env['PARTNER_TOKEN'] ?? "";
    final res = await ApiClient(
      ApiPath.hourlyAssessment,
      headers: {
        'Partner-Token': token,
      },
    ).get(
      {
        'act': 'get_lesson_register',
        "user_key": userKey,
        "txt_date": date,
        "school_id": schoolId,
        "teacher_id": teacherId,
      },
    );
    if (isNullOrEmpty(res['data'])) return [];
    return List<HourlyAssessmentDetailModel>.from(
        res['data'].map((e) => HourlyAssessmentDetailModel.fromJson(e)));
  }

  // Xoa dang ky du gio
  @override
  Future<StatusHourlyAssessmentModel> deleteHourlyAssessment(
      {required String userKey, required int lessonRegisterId}) async {
    final token = dotenv.env['PARTNER_TOKEN'] ?? "";
    final res = await ApiClient(
      ApiPath.hourlyAssessment,
      headers: {
        'Partner-Token': token,
      },
    ).delete(
      {
        'user_key': userKey,
        'lesson_register_id': lessonRegisterId,
      },
      {
        'act': 'delete_lesson_register',
      },
    );
    if (isNullOrEmpty(res)) return StatusHourlyAssessmentModel();
    return StatusHourlyAssessmentModel.fromJson(res);
  }

  // Danh gia du gio tieng Anh
  @override
  Future<void> getEvaluateEnglishHourlyAssessment({
    required String userKey,
    required int lessonRegisterId,
  }) async {
    final token = dotenv.env['PARTNER_TOKEN'] ?? "";
    await ApiClient(
      ApiPath.hourlyAssessment,
      headers: {
        'Partner-Token': token,
      },
    ).get(
      {
        'act': 'lesson_register_note',
        'user_key': userKey,
        'lesson_register_id': lessonRegisterId,
        'lesson_register_id_type': 'EN',
      },
    );
  }

  // Danh gia du gio MOET
  @override
  Future<void> getEvaluateMOETHourlyAssessment({
    required String userKey,
    required int lessonRegisterId,
  }) async {
    final token = dotenv.env['PARTNER_TOKEN'] ?? "";
    await ApiClient(
      ApiPath.hourlyAssessment,
      headers: {
        'Partner-Token': token,
      },
    ).get(
      {
        'act': 'lesson_register_note',
        'user_key': userKey,
        'lesson_register_id': lessonRegisterId,
        'lesson_register_id_type': 'VI',
      },
    );
  }
}
