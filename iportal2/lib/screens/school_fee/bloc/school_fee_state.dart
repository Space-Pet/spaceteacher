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
    this.schoolFeePayWithBalancePreview,
    this.paymentGateways,
    this.gateway,
    this.isLoading = false,
    this.error,
    this.isPayWithBalance = false,
    this.currentTabIndex = 0,
  });
  final SchoolFeeStatus schoolFeeStatus;
  final SchoolFeeHistoryStatus schoolFeeHistoryStatus;
  final PaymentStatus paymentStatus;
  final SchoolFeePreviewStatus schoolFeePreviewStatus;
  final SchoolFee? schoolFee;
  final HistorySchoolFee? historySchoolFee;
  final SchoolFeePaymentPreview? schoolFeePaymentPreview;
  final SchoolFeePaymentPreview? schoolFeePayWithBalancePreview;
  final List<PaymentGateway>? paymentGateways;
  final Gateway? gateway;
  final bool isLoading;
  final String? error;
  final bool? isPayWithBalance;
  final int? currentTabIndex;

  @override
  List<Object?> get props => [
        schoolFeeStatus,
        schoolFeeHistoryStatus,
        paymentStatus,
        schoolFeePreviewStatus,
        schoolFee,
        historySchoolFee,
        schoolFeePaymentPreview,
        schoolFeePayWithBalancePreview,
        paymentGateways,
        gateway,
        isLoading,
        error,
        isPayWithBalance,
        currentTabIndex,
      ];

  SchoolFeeState copyWith(
      {SchoolFeeStatus? schoolFeeStatus,
      SchoolFeeHistoryStatus? schoolFeeHistoryStatus,
      PaymentStatus? paymentStatus,
      SchoolFeePreviewStatus? schoolFeePreviewStatus,
      SchoolFee? schoolFee,
      HistorySchoolFee? historySchoolFee,
      SchoolFeePaymentPreview? schoolFeePaymentPreview,
      SchoolFeePaymentPreview? schoolFeePayWithBalancePreview,
      List<PaymentGateway>? paymentGateways,
      Gateway? gateway,
      bool? isLoading,
      String? error,
      bool? isPayWithBalance,
      int? currentTabIndex}) {
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
      schoolFeePayWithBalancePreview:
          schoolFeePayWithBalancePreview ?? this.schoolFeePayWithBalancePreview,
      paymentGateways: paymentGateways ?? this.paymentGateways,
      gateway: gateway ?? this.gateway,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isPayWithBalance: isPayWithBalance ?? this.isPayWithBalance,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }
}
