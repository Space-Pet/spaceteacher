part of 'hourly_assessment_bloc.dart';

enum HourlyAssessmentStatus {
  init,
  loading,
  success,
  failure,
  updating,
  updateSuccess,
  updateFailure
}

class HourlyAssessmenState extends Equatable {
  final HourlyAssessmentStatus status;
  final MoetEvaluation moetEvaluation;
  final String errorMsg;

  const HourlyAssessmenState({
    required this.moetEvaluation,
    this.status = HourlyAssessmentStatus.init,
    this.errorMsg = '',
  });

  @override
  List<Object?> get props => [moetEvaluation, status, errorMsg];

  HourlyAssessmenState copyWith({
    HourlyAssessmentStatus? status,
    MoetEvaluation? moetEvaluation,
    String? errorMsg,
  }) {
    return HourlyAssessmenState(
      moetEvaluation: moetEvaluation ?? this.moetEvaluation,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
