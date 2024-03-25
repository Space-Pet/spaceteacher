class RequestInfo {
  final int count;
  final List<RequestData> result;
  const RequestInfo({
    required this.count,
    required this.result,
  });

  factory RequestInfo.fromMap(Map<String, dynamic> map) {
    final count = map['count'] ?? 0;
    final result = (map['result'] as List<dynamic>?)
        ?.map((requestMap) => RequestData.fromMap(requestMap))
        .toList();

    return RequestInfo(
      count: count,
      result: result ?? [],
    );
  }
}

class RequestData {
  final int pk;
  final int intActive;
  final int pkUser;
  final int pkReceive;
  final String userName;
  final String userNameReceive;
  final String code;
  final String quantity;
  final String address;
  final String strType;
  final String phone;
  final DateTime createDate;
  final DateTime implementationData;
  final String status;
  final String companyName;
  final String requestName;
  final int quantityScanTotal;
  final String typeOrder;
  final List<OrderData> order;
  const RequestData(
      {required this.createDate,
      required this.pk,
      required this.implementationData,
      required this.intActive,
      required this.quantity,
      required this.code,
      required this.address,
      required this.userName,
      required this.pkReceive,
      required this.pkUser,
      required this.userNameReceive,
      required this.strType,
      required this.phone,
      required this.status,
      required this.typeOrder,
      required this.companyName,
      required this.quantityScanTotal,
      required this.requestName,
      required this.order});

  factory RequestData.fromMap(Map<String, dynamic> map) {
    final userDetail = map['user_detail'];
    final receiveUserDetail = map['receive_user_detail'];

    final int pkUserDetail = userDetail?['pk'] ?? 0;
    final String userNameUserDetail = userDetail?['username'] ?? '';

    final int pkReceiveUserDetail = receiveUserDetail?['pk'] ?? 0;
    final String userNameReceive = receiveUserDetail?['username'] ?? '';
    final List<dynamic> orderList = map['order'] ?? [];
    List<OrderData> orders = [];

    orders =
        orderList.map((orderMap) => OrderData.fromMap(orderMap)).toList();
      return RequestData(
        createDate: map['create_date'] != null
            ? DateTime.tryParse(map['create_date']) ?? DateTime.now()
            : DateTime.now(),
        implementationData: map['implementation_date'] != null
            ? DateTime.tryParse(map['implementation_date']) ?? DateTime.now()
            : DateTime.now(),
        pk: map['pk'] ?? 0,
        requestName: map['request_name'] ?? '',
        companyName: map['company_name'] ?? '',
        intActive: map['active'] ?? 0,
        phone: map['company_phone'] ?? '',
        quantity: map['quantity'] ?? '',
        strType: map['type'] ?? '',
        code: map['code'] ?? '',
        address: map['address'] ?? '',
        quantityScanTotal: map['quantity_scan_total'] ?? 0,
        pkReceive: pkReceiveUserDetail,
        userName: userNameUserDetail,
        pkUser: pkUserDetail,
        userNameReceive: userNameReceive,
        status: map['status'] ?? '',
        typeOrder: map['type_order'] ?? '',
        order: orders);
  }
}

class OrderData {
  final int pk;
  final String cardType;
  final int status;
  final DateTime implementationDate;
  final String code;
  final double quantity;

  const OrderData({
    required this.pk,
    required this.cardType,
    required this.status,
    required this.implementationDate,
    required this.code,
    required this.quantity,
  });

  factory OrderData.fromMap(Map<String, dynamic> map) {
    return OrderData(
      pk: map['pk'] ?? 0,
      cardType: map['card_type'] ?? '',
      status: map['status'] ?? 0,
      implementationDate: map['implementation_date'] != null
          ? DateTime.tryParse(map['implementation_date']) ?? DateTime.now()
          : DateTime.now(),
      code: map['code'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
    );
  }
}

class HireWorkers {
  final int pk;
  final String quantity;
  final String phone;
  final String companyName;
  final String address;
  final int? quantityReality;
  const HireWorkers({
    required this.pk,
    required this.quantity,
    required this.address,
    required this.companyName,
    required this.phone,
    required this.quantityReality,
  });
  factory HireWorkers.fromMap(Map<String, dynamic> map) {
    final pk = map['pk'] ?? 0;
    final quantity = map['quantity'] ?? '';
    final address = map['address'] ?? '';
    final phone = map['company_phone'] ?? '';
    final quantityReality = map['quantity_reality'] ?? 0;
    final companyName = map['company_name'] ?? '';

    return HireWorkers(
      pk: pk,
      quantity: quantity,
      phone: phone,
      address: address,
      companyName: companyName,
      quantityReality: quantityReality,
    );
  }
}
