class QuantityScanTotal {
  final int quantityTotal;
  final int quantityReality;
  final String status;
  final List<int> highlightStatus;
  const QuantityScanTotal(
      {required this.quantityTotal,
      required this.quantityReality,
      required this.highlightStatus,
      required this.status});
  factory QuantityScanTotal.fromMap(Map<String, dynamic> map) {
    return QuantityScanTotal(
      quantityTotal: map['role_quantity_scan'] ?? 0,
      quantityReality: map['role_quantity_reality'] ?? 0,
      status: map['status'] ?? '',
      highlightStatus: List<int>.from(map['highlight_status'] ?? []),
    );
  }
}
