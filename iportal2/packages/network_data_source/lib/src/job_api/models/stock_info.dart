class StockInfo {
  final String name;
  final String addressForm;
  final int availableShelved;
  final String partitionArea;
  final int totalSumCell;
  final int totalCellHaveSave;
  final int pk;
  const StockInfo({
    required this.totalCellHaveSave,
    required this.name,
    required this.addressForm,
    required this.availableShelved,
    required this.partitionArea,
    required this.pk,
    required this.totalSumCell
  });
  factory StockInfo.fromMap(Map<String, dynamic>map){
    return StockInfo(
      totalCellHaveSave: map['total_cell_have_save'] ?? '',
      totalSumCell: map['total_sum_cell'] ?? '',
      name: map['name'] ?? '',
      pk: map['pk'] ?? '',
      addressForm: map['addressform'] ?? '',
      availableShelved: map['available_shelved'] ?? '',
      partitionArea: map['partition_area'] ?? '',

    );
  }
}