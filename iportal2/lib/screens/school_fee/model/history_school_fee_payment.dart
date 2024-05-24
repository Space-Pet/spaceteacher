class HistorySchoolFeePayment {
  final int? id;
  final String? billId;
  final String? paymentMethod;
  final String? paymentDate;
  final int? amount;

  HistorySchoolFeePayment({
    this.id,
    this.billId,
    this.paymentMethod,
    this.paymentDate,
    this.amount,
  });

  HistorySchoolFeePayment copyWith({
    int? id,
    String? billId,
    String? paymentMethod,
    String? paymentDate,
    int? amount,
  }) {
    return HistorySchoolFeePayment(
      id: id ?? this.id,
      billId: billId ?? this.billId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentDate: paymentDate ?? this.paymentDate,
      amount: amount ?? this.amount,
    );
  }
}
