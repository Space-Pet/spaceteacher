part of 'assessment_bloc.dart';

enum AssessmentStatus {
  init,
  loading,
  success,
  failure,
  updating,
  updateSuccess,
  updateFailure
}

class AssessmenState extends Equatable {
  final AssessmentStatus status;
  final Assessment assessment;
  final String errorMsg;

  const AssessmenState({
    required this.assessment,
    this.status = AssessmentStatus.init,
    this.errorMsg = '',
  });

  @override
  List<Object?> get props => [assessment, status, errorMsg];

  AssessmenState copyWith({
    AssessmentStatus? status,
    Assessment? assessment,
    String? errorMsg,
  }) {
    return AssessmenState(
      assessment: assessment ?? this.assessment,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
