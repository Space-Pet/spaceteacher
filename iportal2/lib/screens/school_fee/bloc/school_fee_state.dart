part of 'school_fee_bloc.dart';

enum SchoolFeeStatus {
  initial,
  loading,
  loaded,
  error,
}

enum SchoolFeeHistoryStatus {
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

enum SchoolFeePreviewStatus {
  initial,
  loading,
  loaded,
  error,
}

class SchoolFeeState extends Equatable {
  const SchoolFeeState({
    this.schoolFeeStatus = SchoolFeeStatus.initial,
    this.schoolFeeHistoryStatus = SchoolFeeHistoryStatus.initial,
    this.paymentStatus = PaymentStatus.initial,
    this.schoolFeePreviewStatus = SchoolFeePreviewStatus.initial,
    this.schoolFee,
    this.historySchoolFee,
    this.schoolFeePaymentPreview,
    this.schoolFeePaymentClearingDebtPreview,
    this.paymentGateways,
    this.gateway,
    this.isLoading = false,
    this.error,
    this.isClearingDebt = false,
  });
  final SchoolFeeStatus schoolFeeStatus;
  final SchoolFeeHistoryStatus schoolFeeHistoryStatus;
  final PaymentStatus paymentStatus;
  final SchoolFeePreviewStatus schoolFeePreviewStatus;
  final SchoolFee? schoolFee;
  final HistorySchoolFee? historySchoolFee;
  final SchoolFeePaymentPreview? schoolFeePaymentPreview;
  final SchoolFeePaymentPreview? schoolFeePaymentClearingDebtPreview;
  final List<PaymentGateway>? paymentGateways;
  final Gateway? gateway;
  final bool isLoading;
  final String? error;
  final bool? isClearingDebt;

  @override
  List<Object?> get props => [
        schoolFeeStatus,
        schoolFeeHistoryStatus,
        paymentStatus,
        schoolFeePreviewStatus,
        schoolFee,
        historySchoolFee,
        schoolFeePaymentPreview,
        schoolFeePaymentClearingDebtPreview,
        paymentGateways,
        gateway,
        isLoading,
        error,
        isClearingDebt,
      ];

  SchoolFeeState copyWith({
    SchoolFeeStatus? schoolFeeStatus,
    SchoolFeeHistoryStatus? schoolFeeHistoryStatus,
    PaymentStatus? paymentStatus,
    SchoolFeePreviewStatus? schoolFeePreviewStatus,
    SchoolFee? schoolFee,
    HistorySchoolFee? historySchoolFee,
    SchoolFeePaymentPreview? schoolFeePaymentPreview,
    SchoolFeePaymentPreview? schoolFeePaymentClearingDebtPreview,
    List<PaymentGateway>? paymentGateways,
    Gateway? gateway,
    bool? isLoading,
    String? error,
    bool? isClearingDebt,
  }) {
    return SchoolFeeState(
      schoolFeeStatus: schoolFeeStatus ?? this.schoolFeeStatus,
      schoolFeeHistoryStatus:
          schoolFeeHistoryStatus ?? this.schoolFeeHistoryStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      schoolFeePreviewStatus:
          schoolFeePreviewStatus ?? this.schoolFeePreviewStatus,
      schoolFee: schoolFee ?? this.schoolFee,
      historySchoolFee: historySchoolFee ?? this.historySchoolFee,
      schoolFeePaymentPreview:
          schoolFeePaymentPreview ?? this.schoolFeePaymentPreview,
      schoolFeePaymentClearingDebtPreview:
          schoolFeePaymentClearingDebtPreview ??
              this.schoolFeePaymentClearingDebtPreview,
      paymentGateways: paymentGateways ?? this.paymentGateways,
      gateway: gateway ?? this.gateway,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isClearingDebt: isClearingDebt ?? this.isClearingDebt,
    );
  }
}
