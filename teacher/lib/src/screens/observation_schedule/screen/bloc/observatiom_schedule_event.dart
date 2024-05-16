part of 'observation_schedule_bloc.dart';

abstract class ObservationScheduleEvent extends Equatable {
  const ObservationScheduleEvent();

  @override
  List<Object> get props => [];
}

class GetObservationSchedule extends ObservationScheduleEvent {
  const GetObservationSchedule({
    required this.userKey,
    required this.dateFrom,
    required this.dateTo,
    required this.classId,
  });
  final String userKey;
  final String dateFrom;
  final String dateTo;
  final int classId;
}

class GetObservationScheduleDetail extends ObservationScheduleEvent {
  const GetObservationScheduleDetail({required this.id});
  final String id;
}

class CreateHourlyAssessment extends ObservationScheduleEvent {
  const CreateHourlyAssessment({
    required this.userKey,
    required this.teacherId,
    required this.classId,
    required this.subjectId,
    required this.schoolId,
    required this.date,
    required this.tietNum,
  });
  final String userKey;
  final int teacherId;
  final int classId;
  final int subjectId;
  final int schoolId;
  final String date;
  final int tietNum;
}

class UpdateHourlyAssessment extends ObservationScheduleEvent {
  const UpdateHourlyAssessment({
    required this.userKey,
    required this.lessonRegisterId,
    required this.noteId,
    required this.diemDat,
    required this.tieuChiDiem,
    required this.nhanXet,
  });
  final String userKey;
  final int lessonRegisterId;
  final String noteId;
  final int diemDat;
  final int tieuChiDiem;
  final String nhanXet;
}

class DeleteHourlyAssessment extends ObservationScheduleEvent {
  const DeleteHourlyAssessment({
    required this.userKey,
    required this.lessonRegisterId,
  });
  final String userKey;
  final int lessonRegisterId;
}

class GetListHourlyAssessmentDetail extends ObservationScheduleEvent {
  const GetListHourlyAssessmentDetail({
    required this.userKey,
    required this.schoolId,
    required this.date,
    required this.teacherId,
  });
  final String userKey;
  final int schoolId;
  final String date;
  final int teacherId;
}

class GetEvaluateEngLish extends ObservationScheduleEvent {
  const GetEvaluateEngLish({
    required this.userKey,
    required this.lessonRegisterId,
  });
  final String userKey;
  final int lessonRegisterId;
}

class GetEvaluateMOET extends ObservationScheduleEvent {
  const GetEvaluateMOET({
    required this.userKey,
    required this.lessonRegisterId,
  });
  final String userKey;
  final int lessonRegisterId;
}
