part of 'fee_plan_bloc.dart';

enum FeePlanStatus { initial, loading, loaded, error }

class FeePlanState extends Equatable {
  final String? errorsText;
  final FeePlanStatus status;
  final StudentFeesResponse? studentFeesData;
  final StudentFeesResponse? studentFeesRequestedData;

  final List<FeeItem>? listVerify;

  const FeePlanState({
    this.errorsText,
    this.status = FeePlanStatus.initial,
    this.studentFeesData,
    this.studentFeesRequestedData,
    this.listVerify,
  });

  @override
  List<Object?> get props => [
        errorsText,
        status,
        studentFeesData,
        studentFeesRequestedData,
        listVerify
      ];

  FeePlanState copyWith({
    String? errorsText,
    FeePlanStatus? status,
    StudentFeesResponse? studentFeesData,
    StudentFeesResponse? studentFeesRequestedData,
    List<FeeItem>? listVerify,
  }) {
    return FeePlanState(
      errorsText: errorsText ?? this.errorsText,
      status: status ?? this.status,
      studentFeesData: studentFeesData ?? this.studentFeesData,
      studentFeesRequestedData:
          studentFeesRequestedData ?? this.studentFeesRequestedData,
      listVerify: listVerify ?? this.listVerify,
    );
  }
}
