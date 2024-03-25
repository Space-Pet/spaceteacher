class BarcodeDeclaration {
  final String statusText;
  final String newCell;
  final String barcode;
  final String code;
  final int status;

  BarcodeDeclaration(
      {required this.barcode,
      required this.code,
      required this.status,
      required this.newCell,
      required this.statusText});

  factory BarcodeDeclaration.fromMap(Map<String, dynamic> map) {
    final partDetail = map['part_detail'];
    final newCellDetal = map['new_cell_detail'];
    final newCell = newCellDetal != null ? newCellDetal['code'] ?? '' : '';
    final barcode = partDetail['barcode'];
    final code = partDetail['cell_detail']['code'];
    return BarcodeDeclaration(
        barcode: barcode,
        code: code,
        newCell: newCell,
        statusText: map['status_text'] ?? '',
        status: map['status'] ?? 0);
  }
}
