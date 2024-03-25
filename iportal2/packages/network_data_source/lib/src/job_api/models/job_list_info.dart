
class JobListInfo {
  final String stock;
  final int? pk;
  final String status;
  final String reference;
  final String companyNameSO;
  final String nameSO;
  final String phoneSO;
  final String addressSO;
  final DateTime implementationDate;
  final String quantity;
  final String companyNamePO;
  final String namePO;
  final String phonePO;
  final String addressPO;
  final String cardType;
  final DateTime? createdAt;
  final int? numberTracking;
  final DateTime? creationDate;
  final String nameStock;
  final String addressStock;

  JobListInfo({
    required this.status,
    required this.stock,
    required this.reference,
    required this.companyNameSO,
    required this.nameSO,
    required this.phoneSO,
    required this.addressSO,
    required this.implementationDate,
    required this.quantity,
    required this.phonePO,
    required this.companyNamePO,
    required this.namePO,
    required this.addressPO,
    required this.cardType,
    required this.pk,
    this.createdAt,
    required this.numberTracking,
    required this.creationDate,
    required this.nameStock,
    required this.addressStock
  });

  factory JobListInfo.fromMap(Map<String, dynamic> map) {
    final customerDetail = map['customer_detail'];
    final supplierDetail = map['supplier_detail'];

    final String companyName = customerDetail != null
        ? customerDetail['company_name'] ?? ''
        : (supplierDetail != null
        ? supplierDetail['company_name'] ?? ''
        : '');

    final String phone = customerDetail != null
        ? customerDetail['phone'] ?? ''
        : (supplierDetail != null ? supplierDetail['phone'] ?? '' : '');

    final String address = customerDetail != null
        ? customerDetail['address'] ?? ''
        : (supplierDetail != null ? supplierDetail['address'] ?? '' : '');

    final String name = customerDetail != null
        ? customerDetail['name'] ?? ''
        : (supplierDetail != null ? supplierDetail['name'] ?? '' : '');

    return JobListInfo(
      creationDate: map['creation_date'] != null
          ? DateTime.tryParse(map['creation_date']) ?? DateTime.now() : map['created_at'] != null
          ? DateTime.tryParse(map['created_at']) ?? DateTime.now()
          : DateTime.now(),
      numberTracking: map['number_tracking'] != null ? int.tryParse(map['number_tracking'].toString()) : null,
      status: map['status'] ?? '',
      cardType: map['card_type'] ?? '',
      stock: map['stock'] ?? '',
      pk: map['pk'] != null ? int.tryParse(map['pk'].toString()) : null,
      quantity: map['quantity'] ?? '',
      implementationDate: map['implementation_date'] != null
          ? DateTime.tryParse(map['implementation_date']) ?? DateTime.now()
          : DateTime.now(),
      nameStock: map['name_stock'] ?? '',
      addressStock: map['address_stock'] ?? '',
      reference: map['reference'] ?? '',
      // date: map['date'] ?? '',
      companyNameSO: companyName,
      phoneSO: phone,
      addressSO: address,
      companyNamePO: companyName,
      phonePO: phone,
      addressPO: address,
      nameSO: name,
      namePO: name,
    );
  }
}

