part of 'school_fee_bloc.dart';

abstract class SchoolFeeEvent extends Equatable {
  const SchoolFeeEvent();
}

class FetchSchoolFee extends SchoolFeeEvent {
  const FetchSchoolFee();
  @override
  List<Object> get props => [];
}

class FetchSchoolFeeHistory extends SchoolFeeEvent {
  const FetchSchoolFeeHistory();
  @override
  List<Object> get props => [];
}

class GetSchoolFeePaymentPreview extends SchoolFeeEvent {
  final int totalMoneyPayment;
  const GetSchoolFeePaymentPreview({required this.totalMoneyPayment});
  @override
  List<Object> get props => [totalMoneyPayment];
}

class GetPaymentGateways extends SchoolFeeEvent {
  const GetPaymentGateways();
  @override
  List<Object> get props => [];
}

class OpenPaymentGateway extends SchoolFeeEvent {
  final int paymentId;
  final int totalMoneyPayment;
  const OpenPaymentGateway(
      {required this.paymentId, required this.totalMoneyPayment});
  @override
  List<Object> get props => [paymentId, totalMoneyPayment];
}
