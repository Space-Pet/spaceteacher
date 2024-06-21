part of 'fee_plan_bloc.dart';

class FeePlanState extends Equatable {
  final String? errorsText;
  final FeePlanStatus status;
  final StudentFeesResponse? studentFeesData;
  final StudentFeesResponse? studentFeesRequestedData;
  final LearnYearPayment? currentYearState;
  final FeePlanLearnYearsStatus? learnYearsStatus;
  final FeePlanSendRequestStatus? sendRequestStatus;
  final FeePlanHistoryStatus? historyStatus;

  final List<FeeItem>? listVerify;
  final List<LearnYearPayment>? learnYears;
  final int? currentTabIndex;
  final String? sendRequestStatusText;

  const FeePlanState({
    this.errorsText,
    this.status = FeePlanStatus.initial,
    this.studentFeesData,
    this.studentFeesRequestedData,
    this.listVerify,
    this.learnYears,
    this.currentYearState,
    this.learnYearsStatus = FeePlanLearnYearsStatus.initial,
    this.sendRequestStatus = FeePlanSendRequestStatus.initial,
    this.currentTabIndex = 0,
    this.historyStatus = FeePlanHistoryStatus.initial,
    this.sendRequestStatusText,
  });

  @override
  List<Object?> get props => [
        errorsText,
        status,
        studentFeesData,
        studentFeesRequestedData,
        listVerify,
        learnYears,
        currentYearState,
        learnYearsStatus,
        sendRequestStatus,
        currentTabIndex,
        historyStatus,
        sendRequestStatusText,
      ];

  FeePlanState copyWith({
    String? errorsText,
    FeePlanStatus? status,
    StudentFeesResponse? studentFeesData,
    StudentFeesResponse? studentFeesRequestedData,
    List<FeeItem>? listVerify,
    List<LearnYearPayment>? learnYears,
    LearnYearPayment? currentYearState,
    FeePlanLearnYearsStatus? learnYearsStatus,
    FeePlanSendRequestStatus? sendRequestStatus,
    int? currentTabIndex,
    FeePlanHistoryStatus? historyStatus,
    String? sendRequestStatusText,
  }) {
    return FeePlanState(
      errorsText: errorsText ?? this.errorsText,
      status: status ?? this.status,
      studentFeesData: studentFeesData ?? this.studentFeesData,
      studentFeesRequestedData:
          studentFeesRequestedData ?? this.studentFeesRequestedData,
      listVerify: listVerify ?? this.listVerify,
      learnYears: learnYears ?? this.learnYears,
      currentYearState: currentYearState ?? this.currentYearState,
      learnYearsStatus: learnYearsStatus ?? this.learnYearsStatus,
      sendRequestStatus: sendRequestStatus ?? this.sendRequestStatus,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      historyStatus: historyStatus ?? this.historyStatus,
      sendRequestStatusText:
          sendRequestStatusText ?? this.sendRequestStatusText,
    );
  }
}
