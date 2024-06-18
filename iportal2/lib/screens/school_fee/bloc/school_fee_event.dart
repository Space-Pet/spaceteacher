part of 'school_fee_bloc.dart';

abstract class SchoolFeeEvent extends Equatable {
  const SchoolFeeEvent();
}

class FetchSchoolFee extends SchoolFeeEvent {
  const FetchSchoolFee({this.learnYear});
  final String? learnYear;
  @override
  List<Object> get props => [];
}

class FetchSchoolFeeHistory extends SchoolFeeEvent {
  const FetchSchoolFeeHistory({this.learnYear});
  final String? learnYear;
  @override
  List<Object> get props => [];
}

class GetSchoolFeePaymentPreview extends SchoolFeeEvent {
  final int totalMoneyPayment;
  final String? learnYear;
  const GetSchoolFeePaymentPreview(
      {required this.totalMoneyPayment, this.learnYear});
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
  final String? learnYear;
  const OpenPaymentGateway(
      {required this.paymentId,
      required this.totalMoneyPayment,
      this.learnYear});
  @override
  List<Object> get props => [paymentId, totalMoneyPayment];
}

class GetSchoolFeePayWithBalancePreview extends SchoolFeeEvent {
  const GetSchoolFeePayWithBalancePreview(
      {required this.totalMoneyPayment, this.learnYear});
  final int totalMoneyPayment;
  final String? learnYear;
  @override
  List<Object> get props => [totalMoneyPayment];
}

class PayWithBalance extends SchoolFeeEvent {
  const PayWithBalance({required this.totalMoneyPayment, this.learnYear});
  final int totalMoneyPayment;
  final String? learnYear;
  @override
  List<Object> get props => [totalMoneyPayment];
}

class UpdateStatusSchoolFeeEvent extends SchoolFeeEvent {
  const UpdateStatusSchoolFeeEvent({
    this.schoolFeeHistoryStatus = SchoolFeeHistoryStatus.initial,
    this.schoolFeeStatus = SchoolFeeStatus.initial,
    this.paymentStatus = PaymentStatus.initial,
    this.schoolFeePreviewStatus = SchoolFeePreviewStatus.initial,
  });
  final SchoolFeeHistoryStatus schoolFeeHistoryStatus;
  final SchoolFeeStatus schoolFeeStatus;
  final PaymentStatus paymentStatus;
  final SchoolFeePreviewStatus schoolFeePreviewStatus;
  @override
  List<Object> get props => [];
}

class UpdateTabIndexEvent extends SchoolFeeEvent {
  final int tabIndex;

  const UpdateTabIndexEvent(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}

class GetLearnYears extends SchoolFeeEvent {
  final int number;
  const GetLearnYears({required this.number});
  @override
  List<Object> get props => [number];
}

class UpdateCurrentYearEvent extends SchoolFeeEvent {
  final LearnYear currentYear;

  const UpdateCurrentYearEvent(this.currentYear);

  @override
  List<Object> get props => [currentYear];
}
