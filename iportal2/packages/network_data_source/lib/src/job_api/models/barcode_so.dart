class BarcodeSO {
  final String partName;
  final String statusText;
  final int status;

  BarcodeSO({
    required this.partName,
    required this.status,
    required this.statusText,
  });

  factory BarcodeSO.fromMap(Map<String, dynamic> map) {
    return BarcodeSO(
      partName: map['part_name'] ?? '',
      status: map['status'] is int ? map['status'] : int.tryParse(map['status']) ?? 0,
      statusText: map['status_text'] ?? '',
    );
  }
}
