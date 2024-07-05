part of 'assessment_bloc.dart';

abstract class AssessmentEvent extends Equatable {}

class GetAssessmentCriterias extends AssessmentEvent {
  GetAssessmentCriterias({
    required this.lessonRegisterId,
    this.isRefresh = false,
    this.type = 'VI_VN',
  });

  final String lessonRegisterId;
  final bool isRefresh;
  final String type;

  @override
  List<Object?> get props => [lessonRegisterId, isRefresh, type];
}

class UpdateCriteria extends AssessmentEvent {
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
