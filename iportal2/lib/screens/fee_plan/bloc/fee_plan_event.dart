part of 'fee_plan_bloc.dart';

abstract class FeePlanEvent extends Equatable {
  const FeePlanEvent();

  @override
  List<Object> get props => [];
}

class GetListFee extends FeePlanEvent {
  const GetListFee({this.learnYear});
  final String? learnYear;
}

class GetFeeRequested extends FeePlanEvent {
  const GetFeeRequested({this.learnYear});
  final String? learnYear;
}

class SendFeeRequested extends FeePlanEvent {
  final List<FeeItem> listItemFee;
  final String? learnYear;
  const SendFeeRequested({required this.listItemFee, this.learnYear});

  @override
  List<Object> get props => [listItemFee];
}

class AddFeeToListVerify extends FeePlanEvent {
  final FeeItem feeItem;

  const AddFeeToListVerify({required this.feeItem});

  @override
  List<Object> get props => [feeItem];
}

class RemoveFeeFromListVerify extends FeePlanEvent {
  final FeeItem feeItem;

  const RemoveFeeFromListVerify({required this.feeItem});
}

class GetListLearnYear extends FeePlanEvent {
  final int number;
  const GetListLearnYear({required this.number});
  @override
  List<Object> get props => [number];
}

class UpdateCurrentYear extends FeePlanEvent {
  final LearnYearPayment currentYearState;

  const UpdateCurrentYear({required this.currentYearState});
}

class UpdateCurrentTabIndex extends FeePlanEvent {
  final int currentTabIndex;

  const UpdateCurrentTabIndex({required this.currentTabIndex});
}

class UpdateStatusFeePlan extends FeePlanEvent {
  final FeePlanStatus status;
  final FeePlanSendRequestStatus sendRequestStatus;
  final FeePlanHistoryStatus historyStatus;
  final FeePlanLearnYearsStatus learnYearsStatus;

  const UpdateStatusFeePlan({
    this.status = FeePlanStatus.initial,
    this.sendRequestStatus = FeePlanSendRequestStatus.initial,
    this.historyStatus = FeePlanHistoryStatus.initial,
    this.learnYearsStatus = FeePlanLearnYearsStatus.initial,
  });
  @override
  // TODO: implement props
  List<Object> get props => [
        status,
        sendRequestStatus,
        historyStatus,
        learnYearsStatus,
      ];
}
