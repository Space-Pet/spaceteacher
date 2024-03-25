import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/constants.dart';
import 'booking_address_type.dart';
import 'payment_method.dart';
import 'position.dart';
import 'service.dart';
import 'voucher.dart';

export '../../common/constants.dart';
export 'booking_address_type.dart';
export 'service.dart';

part 'booking.g.dart';

@JsonSerializable(explicitToJson: true)
class Booking {
  String? id;
  Service? service;
  String? code;
  @JsonKey(
    name: 'status',
    unknownEnumValue: BookingStatus.unknown,
  )
  BookingStatus? status;
  @JsonKey(name: 'scheduled_at')
  DateTime? scheduledAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'end_time')
  DateTime? endTime;
  @JsonKey(name: 'working_time')
  int? workingTime;
  int? total;
  @JsonKey(name: 'surcharge_price')
  int? surchargePrice;
  @JsonKey(name: 'additional_services')
  List<AdditionalServices>? additionalServices;
  String? note;
  String? description;
  @JsonKey(name: 'booking_addresses')
  List<BookingAddress>? bookingAddresses;
  @JsonKey(name: 'booking_files')
  List<BookingFile>? bookingFiles;
  @JsonKey(name: 'service_charge')
  num? serviceCharge;
  @JsonKey(name: 'additional_charge')
  int? additionalCharge;
  @JsonKey(name: 'fee_price')
  int? feePrice;
  @JsonKey(name: 'personal_tax_price')
  int? personalTaxPrice;
  @JsonKey(name: 'tax_VAT_price')
  int? taxVATPrice;
  @JsonKey(name: 'service_price')
  double? servicePrice;
  int? rating;
  @JsonKey(name: 'hourly_charge')
  num? hourlyCharge;
  @JsonKey(name: 'promotion')
  Voucher? voucher;
  @JsonKey(name: 'temp_promotion')
  Voucher? tempVoucher;
  @JsonKey(name: 'promotion_amount')
  int? promotionAmount;
  List<Invoices>? invoices;
  @JsonKey(name: 'paid_at')
  String? paidAt;
  @JsonKey(name: 'canceled_reason')
  String? canceledReason;
  @JsonKey(name: 'conversation_id')
  String? conversationId;
  @JsonKey(name: 'refund_amount')
  int? refundAmount;
  @JsonKey(name: 'certificate_required')
  bool? certificateRequired;
  @JsonKey(name: 'statistics')
  Statistics? statistics;
  @JsonKey(name: 'position')
  Position? position;
  @JsonKey(name: 'partner_rate')
  int? partnerRate;
  @JsonKey(name: 'partner_comment')
  String? partnerComment;
  @JsonKey(name: 'canceled_by')
  String? canceledBy;

  num get tempFee {
    return (hourlyCharge ?? 0) * (workingTime ?? 0) + (serviceCharge ?? 0);
  }
  int get totalFees {
   return (feePrice ?? 0) + (taxVATPrice ?? 0) + (personalTaxPrice ?? 0);
  }
  int get totalteacher {
     return (servicePrice?.toInt() ?? 0) - totalFees;
  }
  Booking({
    this.id,
    this.service,
    this.code,
    this.status,
    this.scheduledAt,
    this.createdAt,
    this.workingTime,
    this.total,
    this.additionalServices,
    this.note,
    this.description,
    this.bookingAddresses,
    this.endTime,
    this.bookingFiles,
    this.rating,
    this.hourlyCharge,
    this.serviceCharge,
    this.additionalCharge,
    this.voucher,
    this.promotionAmount,
    this.tempVoucher,
    this.invoices,
    this.paidAt,
    this.canceledReason,
    this.conversationId,
    this.refundAmount,
    this.certificateRequired,
    this.statistics,
    this.surchargePrice,
    this.position,
    this.servicePrice,
    this.partnerRate,
    this.partnerComment,
    this.canceledBy,
    this.feePrice,
    this.taxVATPrice,
    this.personalTaxPrice,
  });
  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);

  Color get getBookingStatusColor {
    switch (status) {
      case BookingStatus.neww:
        if (isExpired) {
          return const Color(0xFF828282);
        }
        return const Color(0xFFA66EFA);
      case BookingStatus.assigned:
        return const Color(0xFFFC8B56);
      case BookingStatus.inProgress:
        return const Color(0xFF08A2FF);
      case BookingStatus.confirming:
        return const Color(0xFFFF558E);
      case BookingStatus.completed:
        return const Color(0xFF05B340);
      case BookingStatus.canceled:
        return const Color(0xFFEE1602);
      default:
        return Colors.transparent;
    }
  }

  String getBookingStatusTitle(dynamic trans) {
    switch (status) {
      case BookingStatus.neww:
        if (isExpired) {
          return trans.expired;
        }
        return trans.waitingForReceiving;
      case BookingStatus.assigned:
        return trans.received;
      case BookingStatus.inProgress:
        return trans.inProgress;
      case BookingStatus.confirming:
        return trans.confirming;
      case BookingStatus.completed:
        return trans.completed;
      case BookingStatus.canceled:
        return trans.canceled;
      default:
        return '';
    }
  }

  bool get isExpired =>
      status == BookingStatus.neww &&
      scheduledAt?.toLocal().isBefore(DateTime.now()) == true;

  bool get isCancled => status == BookingStatus.canceled;

  bool get isNew => status == BookingStatus.neww && !isExpired;

  bool get isCompleted => status == BookingStatus.completed;

  bool get shouldShowCountdown =>
      status == BookingStatus.neww || status == BookingStatus.assigned;

  num get totalWorkingTime {
    final additionalHours = additionalServices?.sumBy((e) => e.totalHours);
    return (additionalHours ?? 0) + (workingTime ?? 0);
  }

  bool get isCleaning {
    return service?.id == ServiceType.cleaning;
  }

  bool get canCancel {
    if (isCleaning) {
      return status == BookingStatus.assigned;
    } else {
      return status == BookingStatus.assigned ||
          status == BookingStatus.inProgress ||
          status == BookingStatus.confirming;
    }
  }

  bool get canCallHotline {
    if (isCleaning) {
      return status == BookingStatus.assigned ||
          status == BookingStatus.inProgress;
    } else {
      return status == BookingStatus.assigned ||
          status == BookingStatus.inProgress ||
          status == BookingStatus.completed ||
          status == BookingStatus.confirming;
    }
  }

  String getServiceName(String languageCode) {
    return service?.contents
            ?.where((element) => element.language == languageCode)
            .firstOrNull
            ?.name ??
        '';
  }
}

@JsonSerializable(explicitToJson: true)
class Statistics {
  @JsonKey(name: 'partner_income')
  int? partnerIncome;
  @JsonKey(name: 'paid_at')
  DateTime? paidAt;
  Statistics({
    this.partnerIncome,
    this.paidAt,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Invoices {
  @JsonKey(name: 'payment_method')
  PaymentMethod? paymentMethod;

  Invoices({this.paymentMethod});

  factory Invoices.fromJson(Map<String, dynamic> json) =>
      _$InvoicesFromJson(json);

  Map<String, dynamic> toJson() => _$InvoicesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookingAddress {
  @JsonKey(name: 'contact_name')
  String? contactName;
  @JsonKey(name: 'phone_code')
  int? phoneCode;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  @JsonKey(name: 'address_type')
  BookingAddressType? addressType;
  @JsonKey(name: 'province_code')
  String? provinceCode;
  @JsonKey(name: 'province_name')
  String? provinceName;
  @JsonKey(name: 'district_code')
  String? districtCode;
  @JsonKey(name: 'district_name')
  String? districtName;
  @JsonKey(name: 'ward_code')
  String? wardCode;
  @JsonKey(name: 'ward_name')
  String? wardName;
  String? street;
  Position? position;
  String? type;
  @JsonKey(name: 'address_name')
  String? addressName;
  @JsonKey(name: 'full_address')
  String? fullAddress;

  BookingAddress({
    this.contactName,
    this.phoneCode,
    this.phoneNumber,
    this.addressType,
    this.provinceCode,
    this.provinceName,
    this.districtCode,
    this.districtName,
    this.wardCode,
    this.wardName,
    this.street,
    this.position,
    this.type,
    this.addressName,
    this.fullAddress,
  });

  String get fullAddressDescription {
    if ((street == null || street!.isEmpty) && fullAddress != null) {
      return fullAddress!;
    }
    return [street, wardName, districtName, provinceName]
        .where((element) => element != null && element.isNotEmpty == true)
        .join(', ');
  }

  factory BookingAddress.fromJson(Map<String, dynamic> json) =>
      _$BookingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$BookingAddressToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookingFile {
  String? url;
  @JsonKey(name: 'mime_type')
  String? mimeType;
  String? name;

  BookingFile({
    this.url,
    this.mimeType,
    this.name,
  });

  factory BookingFile.fromJson(Map<String, dynamic> json) =>
      _$BookingFileFromJson(json);

  Map<String, dynamic> toJson() => _$BookingFileToJson(this);
}

enum BookingStatus {
  @JsonValue('new')
  neww,
  @JsonValue('assigned')
  assigned,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('confirming')
  confirming,
  @JsonValue('completed')
  completed,
  @JsonValue('canceled')
  canceled,
  @JsonValue('is_fake')
  isFake,
  @JsonValue('unknown')
  unknown
}
