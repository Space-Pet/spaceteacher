part of 'school_fee_bloc.dart';

enum SchoolFeeStatus { initial, loading, loaded, error }

class SchoolFeeState extends Equatable {
  const SchoolFeeState(
      {this.schoolFeeStatus = SchoolFeeStatus.initial,
      this.schoolFee,
      this.historySchoolFee,
      this.schoolFeePaymentPreview,
      this.paymentGateways,
      this.isLoading = false,
      this.error});
  final SchoolFeeStatus schoolFeeStatus;
  final SchoolFee? schoolFee;
  final HistorySchoolFee? historySchoolFee;
  final SchoolFeePaymentPreview? schoolFeePaymentPreview;
  final List<PaymentGateway>? paymentGateways;
  final bool isLoading;
  final String? error;

  @override
  List<Object?> get props => [
        schoolFeeStatus,
        schoolFee,
        historySchoolFee,
        schoolFeePaymentPreview,
        paymentGateways,
        isLoading,
        error
      ];

  SchoolFeeState copyWith({
    SchoolFeeStatus? schoolFeeStatus,
    SchoolFee? schoolFee,
    HistorySchoolFee? historySchoolFee,
    SchoolFeePaymentPreview? schoolFeePaymentPreview,
    List<PaymentGateway>? paymentGateways,
    bool? isLoading,
    String? error,
  }) {
    return SchoolFeeState(
      schoolFeeStatus: schoolFeeStatus ?? this.schoolFeeStatus,
      schoolFee: schoolFee ?? this.schoolFee,
      historySchoolFee: historySchoolFee ?? this.historySchoolFee,
      schoolFeePaymentPreview:
          schoolFeePaymentPreview ?? this.schoolFeePaymentPreview,
      paymentGateways: paymentGateways ?? this.paymentGateways,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
