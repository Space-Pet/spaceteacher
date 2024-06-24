part of 'hourly_assessment_bloc.dart';

abstract class HourlyAssessmentEvent extends Equatable {}

class GetMoetEvaluationForm extends HourlyAssessmentEvent {
  GetMoetEvaluationForm({required this.lessonRegisterId});

  final String lessonRegisterId;

  @override
  List<Object?> get props => [lessonRegisterId];
}

class UpdateCriteria extends HourlyAssessmentEvent {
  final String lessonRegisterId;
  final String noteId;
  final String diemDat;
  final String tieuChiDiem;
  final String nhanXet;

  UpdateCriteria({
    required this.lessonRegisterId,
    required this.noteId,
    required this.diemDat,
    required this.tieuChiDiem,
    required this.nhanXet,
  });

  @override
  List<Object?> get props => [
        lessonRegisterId,
        noteId,
        diemDat,
        tieuChiDiem,
        nhanXet,
      ];
}
