part of 'school_fee_bloc.dart';

enum SchoolFeeStatus {
  initial,
  loading,
  loaded,
  error,
}

enum PaymentStatus {
  initial,
  loading,
  loaded,
  error,
}

class SchoolFeeState extends Equatable {
  const SchoolFeeState(
      {this.schoolFeeStatus = SchoolFeeStatus.initial,
      this.paymentStatus = PaymentStatus.initial,
      this.schoolFee,
      this.historySchoolFee,
      this.schoolFeePaymentPreview,
      this.paymentGateways,
      this.gateway,
      this.isLoading = false,
      this.error});
  final SchoolFeeStatus schoolFeeStatus;
  final PaymentStatus paymentStatus;
  final SchoolFee? schoolFee;
  final HistorySchoolFee? historySchoolFee;
  final SchoolFeePaymentPreview? schoolFeePaymentPreview;
  final List<PaymentGateway>? paymentGateways;
  final Gateway? gateway;
  final bool isLoading;
  final String? error;

  @override
  List<Object?> get props => [
        schoolFeeStatus,
        paymentStatus,
        schoolFee,
        historySchoolFee,
        schoolFeePaymentPreview,
        paymentGateways,
        gateway,
        isLoading,
        error
      ];

  SchoolFeeState copyWith({
    SchoolFeeStatus? schoolFeeStatus,
    PaymentStatus? paymentStatus,
    SchoolFee? schoolFee,
    HistorySchoolFee? historySchoolFee,
    SchoolFeePaymentPreview? schoolFeePaymentPreview,
    List<PaymentGateway>? paymentGateways,
    Gateway? gateway,
    bool? isLoading,
    String? error,
  }) {
    return SchoolFeeState(
      schoolFeeStatus: schoolFeeStatus ?? this.schoolFeeStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      schoolFee: schoolFee ?? this.schoolFee,
      historySchoolFee: historySchoolFee ?? this.historySchoolFee,
      schoolFeePaymentPreview:
          schoolFeePaymentPreview ?? this.schoolFeePaymentPreview,
      paymentGateways: paymentGateways ?? this.paymentGateways,
      gateway: gateway ?? this.gateway,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
