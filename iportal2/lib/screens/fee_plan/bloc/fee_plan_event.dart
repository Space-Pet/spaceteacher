part of 'fee_plan_bloc.dart';

abstract class FeePlanEvent extends Equatable {
  const FeePlanEvent();

  @override
  List<Object> get props => [];
}

class GetListFee extends FeePlanEvent {
  const GetListFee();
}

class GetFeeRequested extends FeePlanEvent {
  const GetFeeRequested();
}

class SendFeeRequested extends FeePlanEvent {
  final List<FeeItem> listItemFee;

  const SendFeeRequested({required this.listItemFee});

  @override
  // TODO: implement props
  List<Object> get props => [listItemFee];
}
