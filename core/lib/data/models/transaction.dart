import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils.dart';
import '../../presentation/theme/theme_color.dart';
import 'booking.dart';

part 'transaction.g.dart';

@JsonSerializable(explicitToJson: true)
class UserTransaction {
  @JsonKey(name: 'request_id')
  String? requestId;
  @JsonKey(name: 'wallet_type_id')
  String? walletTypeId;
  int? amount;
  @JsonKey(name: 'transaction_request')
  TransactionRequest? transactionRequest;
  @JsonKey(name: 'is_sender')
  bool? isSender;
  @JsonKey(name: 'transaction_info')
  bool? transactionInfo;

  UserTransaction({
    this.amount,
    this.transactionRequest,
    this.isSender,
    this.requestId,
    this.transactionInfo,
    this.walletTypeId,
  });

  factory UserTransaction.fromJson(Map<String, dynamic> json) =>
      _$UserTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$UserTransactionToJson(this);

  bool get isOutflow => isSender == true;

  bool get isDefaultTransaction => walletTypeId == WalletType.defaultWallet;
  bool get isTransfer =>
      transactionRequest?.type == TransactionType.transfer &&
      transactionRequest?.booking?.code == null;
  bool get isDeposit => transactionRequest?.type == TransactionType.deposit;
  bool get isBookingFee =>
      transactionRequest?.type == TransactionType.transfer &&
      transactionRequest?.booking?.code != null;

  bool get isBonusTransaction => walletTypeId == WalletType.bonusWallet;

  String get getBookingCode => transactionRequest?.booking?.code ?? '';

  String get getTransactionCode => transactionRequest?.code ?? '';

  String get getTransactionWithdrawInfo =>
      transactionRequest?.transactionInfo ?? '';

  String getTracsactionTitle(dynamic trans) {
    switch (walletTypeId) {
      case WalletType.defaultWallet:
        switch (transactionRequest?.transactionPaymentType) {
          case TransactionType.bookingFee:
            return '${trans.bookingFee} $getBookingCode';
          case TransactionType.tranSfer:
            return trans.transfer;
          case TransactionType.withDraw:
            return trans.withdraw;
          case TransactionType.topUp:
            return trans.topup;
          case TransactionType.refund:
            return trans.refund;
          case TransactionType.bookingTax:
            return '${trans.bookingTax} $getBookingCode';
          case TransactionType.bookingReceived:
            return '${trans.bookingReceived} $getBookingCode';
          case TransactionType.bookingPromotion:
            return trans.bookingPromotion;
        }
        return '';
      case WalletType.bonusWallet:
        switch (transactionRequest?.type) {
          case TransactionType.deposit:
            return trans.topup;
          case TransactionType.withdraw:
            return trans.withdrawBonusWallet;
          case TransactionType.transfer:
            if (transactionRequest?.referenceType ==
                PaymentMethodType.bonusToDefault) {
              return trans.transferToMainWallet;
            }
            if (transactionRequest?.referenceType ==
                PaymentMethodType.kpiBonus) {
              switch (transactionRequest?.kpiSetting?.type) {
                case KpiType.day:
                  return trans.bonusKPIDay;
                case KpiType.month:
                  return trans.bonusKPIMonth;
                case KpiType.week:
                  return trans.bonusKPIWeek;
                case KpiType.year:
                  return trans.bonusKPIYear;
              }
              return '';
            }
            if (transactionRequest?.referenceType ==
                TransactionType.referralBonus) {
              return trans.referralBonus;
            }
            return '';
        }
        return '';
    }

    return '';
  }

  String get getTracsactionMoneyText {
    if (isSender == true) {
      return '-${amount?.abs().toCurrencyString()}';
    } else {
      return '+${amount?.abs().toCurrencyString()}';
    }
  }

  String getTracsactionPaymentMethod(dynamic trans) {
    switch (transactionRequest?.paymentMethodId) {
      case PaymentMethodType.bank:
        return trans.bankPayment;
      case PaymentMethodType.cash:
        return trans.cashPayment;
      case PaymentMethodType.bonusToDefault:
      case PaymentMethodType.kpiBonus:
      case PaymentMethodType.system:
        return trans.systemPayment;
      case PaymentMethodType.vnpay:
        return trans.vnpay;
      case PaymentMethodType.momo:
        return trans.momo;
      case PaymentMethodType.bonus:
        return trans.bonus;
    }

    return '';
  }

  String getTracsactionStatusTitle(dynamic trans) {
    switch (walletTypeId) {
      case WalletType.defaultWallet:
        switch (transactionRequest?.type) {
          case TransactionType.deposit:
            return trans.completed;
          case TransactionType.withdraw:
            return getWithdrawTracsactionStatus(trans);
          case TransactionType.transfer:
            return trans.completed;
        }
        return '';
      case WalletType.bonusWallet:
        switch (transactionRequest?.type) {
          case TransactionType.deposit:
            switch (transactionRequest?.kpiSetting?.type) {
              case KpiType.day:
                return trans.bonusKPIDay;
              case KpiType.month:
                return trans.bonusKPIMonth;
              case KpiType.week:
                return trans.bonusKPIWeek;
              case KpiType.year:
                return trans.bonusKPIYear;
            }
            return '';
          case TransactionType.withdraw:
            return getWithdrawTracsactionStatus(trans);
          case TransactionType.transfer:
            if (transactionRequest?.referenceType ==
                PaymentMethodType.kpiBonus) {
              return trans.completed;
            }
            return trans.withdrawBonusWallet;
        }
        return '';
    }

    return '';
  }

  Color get getTracsactionStatusColor {
    switch (walletTypeId) {
      case WalletType.defaultWallet:
        switch (transactionRequest?.type) {
          case TransactionType.deposit:
            return themeColor.color0D8330;
          case TransactionType.withdraw:
            return getWithdrawTracsactionColor;
          case TransactionType.transfer:
            return themeColor.color0D8330;
        }
        return themeColor.black;
      case WalletType.bonusWallet:
        switch (transactionRequest?.type) {
          case TransactionType.deposit:
            return themeColor.color0D8330;
          case TransactionType.withdraw:
            return getWithdrawTracsactionColor;
          case TransactionType.transfer:
            if (transactionRequest?.referenceType ==
                PaymentMethodType.kpiBonus) {
              return themeColor.color0D8330;
            }
            return themeColor.colorFF9A05;
        }
        return themeColor.black;
    }
    return themeColor.black;
  }

  Color get transactionPrimaryColor {
    switch (walletTypeId) {
      case WalletType.defaultWallet:
        switch (transactionRequest?.type) {
          case TransactionType.deposit:
            return themeColor.color0D8330;
          case TransactionType.withdraw:
            return themeColor.colorFF9A05;
          case TransactionType.transfer:
            if (transactionRequest?.booking != null) {
              return themeColor.colorFF9A05;
            }
            return themeColor.color0D8330;
        }
        return themeColor.black;
      case WalletType.bonusWallet:
        switch (transactionRequest?.type) {
          case TransactionType.deposit:
            return themeColor.color0D8330;
          case TransactionType.withdraw:
          case TransactionType.transfer:
            if (transactionRequest?.referenceType ==
                PaymentMethodType.kpiBonus) {
              return themeColor.color165CA0;
            }
            return themeColor.colorFF9A05;
        }
        return themeColor.black;
    }
    return themeColor.black;
  }

  String getWithdrawTracsactionStatus(dynamic trans) {
    switch (transactionRequest?.status) {
      case TransactionStatus.processing:
        return trans.processingTransactionStatus;
      case TransactionStatus.success:
        return trans.successTransactionStatus;
      case TransactionStatus.failure:
        return trans.failureTransactionStatus;
      case TransactionStatus.canceled:
        return trans.canceledTransactionStatus;
    }
    return '';
  }

  Color get getWithdrawTracsactionColor {
    switch (transactionRequest?.status) {
      case TransactionStatus.processing:
        return themeColor.colorFF9A05;
      case TransactionStatus.success:
        return themeColor.color0D8330;
      case TransactionStatus.failure:
      case TransactionStatus.canceled:
        return themeColor.colorEE1602;
    }
    return Colors.transparent;
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionRequest {
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  String? type;
  @JsonKey(name: 'reference_type')
  String? referenceType;
  Booking? booking;
  String? code;
  @JsonKey(name: 'transaction_info')
  String? transactionInfo;
  String? status;
  String? note;
  @JsonKey(name: 'kpi_setting')
  KpiSetting? kpiSetting;
  @JsonKey(name: 'payment_method_id')
  String? paymentMethodId;
  @JsonKey(name: 'transaction_payment_type')
  String? transactionPaymentType;
  Metadata? metadata;

  TransactionRequest({
    this.createdAt,
    this.type,
    this.referenceType,
    this.booking,
    this.code,
    this.transactionInfo,
    this.status,
    this.note,
    this.kpiSetting,
    this.paymentMethodId,
    this.transactionPaymentType,
    this.metadata,
  });

  factory TransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$TransactionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Metadata {
  @JsonKey(name: 'transfer_fee_amount')
  double? transferFeeAmount;
  @JsonKey(name: 'transfer_fee_rate')
  double? transferFeeRate;
  @JsonKey(name: 'withdraw_fee_amount')
  double? withdrawFeeAmount;
  @JsonKey(name: 'withdraw_fee_rate')
  double? withdrawFeeRate;

  Metadata({
    this.transferFeeAmount,
    this.transferFeeRate,
    this.withdrawFeeAmount,
    this.withdrawFeeRate,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class KpiSetting {
  String? type;

  KpiSetting({this.type});

  factory KpiSetting.fromJson(Map<String, dynamic> json) =>
      _$KpiSettingFromJson(json);

  Map<String, dynamic> toJson() => _$KpiSettingToJson(this);
}
