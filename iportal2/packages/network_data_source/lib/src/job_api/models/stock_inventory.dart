class StockInventory {
  final String addressform;
  final String name;
  final int status;
  final String partitionArea;
  final int quantityDecleration;
  final int pk;
  const StockInventory(
      {required this.addressform,
      required this.name,
      required this.partitionArea,
      required this.quantityDecleration,
      required this.pk,
      required this.status});
  factory StockInventory.fromMap(Map<String, dynamic> map) {
    return StockInventory(
        addressform: map['addressform'] ?? '',
        name: map['name'] ?? '',
        pk: map['pk'] ?? 0,
        status: map['status'] ?? 0,
        partitionArea: map['partitionArea'] ?? '',
        quantityDecleration: map['quantity_stocktaking'] ?? 0);
  }
}
