class EmptyBox {
  final int pk;
  final String quantity;
  final String quantityReality;
  final String partName;

  EmptyBox(
      {required this.partName,
      required this.pk,
      required this.quantity,
      required this.quantityReality});
  factory EmptyBox.fromMap(Map<String, dynamic> map) {
    final String quantity = map['quantity']?.toString() ?? '';
    final String quantityReality = map['quantity_reality']?.toString() ?? '';
    final int pk = map['pk'] as int? ?? 0;
    final String partName = map['part_name']?.toString() ?? '';

    return EmptyBox(
      partName: partName,
      pk: pk,
      quantity: quantity,
      quantityReality: quantityReality,
    );
  }
}
class StatusLine {
  final int status;
  StatusLine({required this.status});
  factory StatusLine.fromMap(Map<String, dynamic>map){
    return StatusLine(status: map['status'] ?? 0);
  }
}