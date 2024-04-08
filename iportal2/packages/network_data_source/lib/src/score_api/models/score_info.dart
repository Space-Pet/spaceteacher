class ScoreData {
  final String nameStock;
  final int quantityScan;
  final int pk;
  final int quantityReality;
  final int statusTicket;
  final String statusText;
  List<Lines> lines;
  final List<int> highlightStatus;
  ScoreData(
      {required this.nameStock,
      required this.quantityReality,
      required this.lines,
      required this.pk,
      required this.highlightStatus,
      required this.statusText,
      required this.statusTicket,
      required this.quantityScan});

  factory ScoreData.fromMap(Map<String, dynamic> map) {
    final lines = map['lines_step'] as List<dynamic>?;
    final List<Lines> line = [];
    if (lines != null) {
      for (final barcode in lines) {
        final barcodeSO = Lines.fromMap(barcode);
        line.add(barcodeSO);
      }
    }
    return ScoreData(
        highlightStatus: List<int>.from(map['status_highlight'] ?? []),
        statusText: map['status_text'] ?? '',
        statusTicket: map['status'] ?? 0,
        quantityReality: map['role_quantity_reality'] ?? 0,
        pk: map['pk'] ?? 0,
        nameStock: map['name_stock'] ?? '',
        quantityScan: map['role_quantity_scan'] ?? 0,
        lines: line);
  }
}

class Lines {
  final String partName;
  final String statusText;
  final int status;
  final String cell;
  const Lines(
      {required this.partName,
      required this.status,
      required this.statusText,
      required this.cell});
  factory Lines.fromMap(Map<String, dynamic> map) {
    return Lines(
        partName: map['part_name'],
        status: map['status'],
        statusText: map['status_text'],
        cell: map['cell'] ?? '');
  }
}
