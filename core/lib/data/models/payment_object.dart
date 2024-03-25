import 'package:json_annotation/json_annotation.dart';

part 'payment_object.g.dart';

@JsonSerializable(explicitToJson: true)
class VnPayPaymentObject {
  @JsonKey(name: 'vnp_TmnCode')
  String? vnpTmnCode;
  @JsonKey(name: 'vnp_Amount')
  double? vnpAmount;
  @JsonKey(name: 'vnp_BankCode')
  String? vnpBankCode;
  @JsonKey(name: 'vnp_BankTranNo')
  String? vnpBankTranNo;
  @JsonKey(name: 'vnp_CardType')
  String? vnpCardType;
  @JsonKey(name: 'vnp_PayDate')
  String? vnpPayDate;
  @JsonKey(name: 'vnp_OrderInfo')
  String? vnpOrderInfo;
  @JsonKey(name: 'vnp_TransactionNo')
  String? vnpTransactionNo;
  @JsonKey(name: 'vnp_ResponseCode')
  String? vnpResponseCode;
  @JsonKey(name: 'vnp_TransactionStatus')
  String? vnpTransactionStatus;
  @JsonKey(name: 'vnp_TxnRef')
  String? vnpTxnRef;
  @JsonKey(name: 'vnp_SecureHashType')
  String? vnpSecureHashType;
  @JsonKey(name: 'vnp_SecureHash')
  String? vnpSecureHash;
  bool? checksum;

  VnPayPaymentObject({
    this.vnpTmnCode,
    this.vnpAmount,
    this.vnpBankCode,
    this.vnpBankTranNo,
    this.vnpCardType,
    this.vnpPayDate,
    this.vnpOrderInfo,
    this.vnpTransactionNo,
    this.vnpResponseCode,
    this.vnpTransactionStatus,
    this.vnpTxnRef,
    this.vnpSecureHashType,
    this.vnpSecureHash,
    this.checksum,
  });

  factory VnPayPaymentObject.fromJson(Map<String, dynamic> json) =>
      _$VnPayPaymentObjectFromJson(json);

  Map<String, dynamic> toJson() => _$VnPayPaymentObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PaymentRequest {
  @JsonKey(name: 'payment_method_id')
  String? paymentMethodId;
  @JsonKey(name: 'payment_url')
  String? paymentUrl;
  @JsonKey(name: 'payment_request_id')
  String? paymentRequestId;

  PaymentRequest(
      {this.paymentMethodId, this.paymentUrl, this.paymentRequestId});

  factory PaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PaymentTopup {
  @JsonKey(name: 'amount')
  double? amount;
  @JsonKey(name: 'transaction_type')
  String? transactionType;
  @JsonKey(name: 'order_info')
  String? orderInfo;
  @JsonKey(name: 'return_url')
  String? returnUrl;
  @JsonKey(name: 'payment_method_id')
  String? paymentMethodId;
  @JsonKey(name: 'locale')
  String? locale;

  PaymentTopup({
    this.amount,
    this.transactionType,
    this.orderInfo,
    this.returnUrl,
    this.paymentMethodId,
    this.locale,
  });

  factory PaymentTopup.fromJson(Map<String, dynamic> json) =>
      _$PaymentTopupFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTopupToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MoMoPaymentObject {
  @JsonKey(name: 'partner_code')
  String? partnerCode;
  @JsonKey(name: 'order_id')
  String? orderId;
  @JsonKey(name: 'request_id')
  String? requestId;
  @JsonKey(name: 'amount')
  BigInt? amount;
  @JsonKey(name: 'order_info')
  String? orderInfo;
  @JsonKey(name: 'order_type')
  String? orderType;
  @JsonKey(name: 'trans_id')
  BigInt? transId;
  @JsonKey(name: 'result_code')
  int? resultCode;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'pay_type')
  String? payType;
  @JsonKey(name: 'response_time')
  BigInt? responseTime;
  @JsonKey(name: 'extra_data')
  String? extraData;
  bool? checksum;

  MoMoPaymentObject({
    this.partnerCode,
    this.orderId,
    this.requestId,
    this.amount,
    this.orderInfo,
    this.orderType,
    this.transId,
    this.resultCode,
    this.message,
    this.payType,
    this.responseTime,
    this.extraData,
    this.checksum,
  });

  factory MoMoPaymentObject.fromJson(Map<String, dynamic> json) =>
      _$MoMoPaymentObjectFromJson(json);

  Map<String, dynamic> toJson() => _$MoMoPaymentObjectToJson(this);
}
