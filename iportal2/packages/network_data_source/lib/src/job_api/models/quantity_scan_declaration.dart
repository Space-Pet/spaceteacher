class QuantityScanDeclaration {
  final int quantityReal;
  final int status;
  const QuantityScanDeclaration(
      {required this.quantityReal, required this.status});

  factory QuantityScanDeclaration.fromMap(Map<String, dynamic> map) {
    return QuantityScanDeclaration(
        quantityReal: map['quantity_real'] ?? 0, status: map['status'] ?? 0);
  }
}
