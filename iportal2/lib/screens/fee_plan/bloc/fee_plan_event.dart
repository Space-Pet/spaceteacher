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
