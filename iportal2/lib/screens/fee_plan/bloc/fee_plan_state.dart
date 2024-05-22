part of 'fee_plan_bloc.dart';

enum FeePlanStatus { initial, loading, loaded, error }

class FeePlanState extends Equatable {
  final String? errorsText;
  final FeePlanStatus status;
  final StudentFeesResponse? studentFeesData;
  final StudentFeesResponse? studentFeesRequestedData;

  const FeePlanState({
    this.errorsText,
    this.status = FeePlanStatus.initial,
    this.studentFeesData,
    this.studentFeesRequestedData,
  });

  @override
  List<Object?> get props =>
      [errorsText, status, studentFeesData, studentFeesRequestedData];

  FeePlanState copyWith({
    String? errorsText,
    FeePlanStatus? status,
    StudentFeesResponse? studentFeesData,
    StudentFeesResponse? studentFeesRequestedData,
  }) {
    return FeePlanState(
      errorsText: errorsText ?? this.errorsText,
      status: status ?? this.status,
      studentFeesData: studentFeesData ?? this.studentFeesData,
      studentFeesRequestedData:
          studentFeesRequestedData ?? this.studentFeesRequestedData,
    );
  }
}
