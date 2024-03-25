class Stocktaking {
  final int pk;
  final String reference;
  final int number;
  final DateTime implementationData;
  final int intStatus;
  const Stocktaking(
      {required this.number,
      required this.pk,
      required this.implementationData,
      required this.reference,
      required this.intStatus});
  factory Stocktaking.fromMap(Map<String, dynamic> map) {
    return Stocktaking(
        number: map['number_tracking'] ?? 0,
        implementationData: map['date'] != null
            ? DateTime.tryParse(map['date']) ?? DateTime.now()
            : DateTime.now(),
        pk: map['pk'] ?? '',
        reference: map['reference'] ?? '',
        intStatus: map['status'] ?? 0);
  }
}
