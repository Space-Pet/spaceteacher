
class TicketDeclaration {
  final int intStatus;
  final String address;
  final String phone;
  final int quantity;
  final int pk;
  final String reference;
  final String declarationTypeText;
  final int declarationLocationType;
  final DateTime implementationData;
  final String name;

  const TicketDeclaration(
      {required this.address,
      required this.phone,
      required this.pk,
      required this.quantity,
      required this.intStatus,
      required this.reference,
      required this.implementationData,
      required this.declarationLocationType,
      required this.declarationTypeText,
      required this.name});

  factory TicketDeclaration.fromMap(Map<String, dynamic> map) {
    return TicketDeclaration(
        pk: map['pk'] ?? '',
        intStatus: map['status'] ?? 0,
        address: map['stock_detail'] == null
            ? ''
            : map['stock_detail']['full_address'] ?? '',
        phone: map['company_detail']['phone'] ?? '',
        name: map['company_detail']['name'] ?? '',
        quantity: map['quantity_declaration'] ?? 0,
        reference: map['reference'] ?? '',
        implementationData: map['implementation_date'] != null
            ? DateTime.tryParse(map['implementation_date']) ?? DateTime.now()
            : DateTime.now(),
        declarationLocationType: map['declaration_location_type'] ?? '',
        declarationTypeText: map['declaration_type_text'] ?? '');
  }
}
