import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'booking.dart';

part 'create_booking_object.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CreateBookingObject {
  /// Hàng mới
  @JsonKey(name: 'booking_promotion')
  List<BookingPromotion>? bookingPromotions;

  @JsonKey(name: 'booking_address')
  CreateBookingAddressData? bookingAddress;
  @JsonKey(name: 'working_time')
  int? workingTime;
  @JsonKey(name: 'service_id')
  String? serviceId;
  @JsonKey(name: 'scheduled_at')
  String? scheduledAt;
  String? description;
  String? note;
  @JsonKey(name: 'booking_files')
  List<CreateBookingFile>? bookingFiles;
  @JsonKey(name: 'additional_services')
  List<CreateBookingAdditionalService>? additionalServices;
// ------------------------------------------------------ //
  /// không sử dung trong version 2.0.4
  @JsonKey(name: 'promotion_id')
  String? promotionId;

  /// không sử dung trong version 2.0.4
  @JsonKey(name: 'temp_promotion_id')
  String? tempPromotionId;
// ------------------------------------------------------ //
  @JsonKey(name: 'iportal_id')
  String? iportalId;
  @JsonKey(name: 'service_item_id')
  String? serviceItemId;
  @JsonKey(ignore: true)
  Address? address;
  @JsonKey(ignore: true)
  ServiceItems? serviceItems;
  @JsonKey(ignore: true)
  ServiceItems? referencePackage;
  @JsonKey(name: 'payment_method_id')
  String? paymentMethodId;
  @JsonKey(name: 'locale')
  String? locale;
  @JsonKey(name: 'vnp_return_url')
  String? vnpReturnUrl;
  @JsonKey(name: 'momo_redirect_url')
  String? momoRedirectUrl;
  @JsonKey(name: 'certificate_required')
  bool? certificateRequired;
  double? total;
  @JsonKey(name: 'surcharge_price')
  double? surchargePrice;
  @JsonKey(name: 'service_charge')
  double? serviceCharge;
  @JsonKey(name: 'fee_price')
  double? feePrice;
  @JsonKey(name: 'personal_tax_price')
  double? personalTaxPrice;
  @JsonKey(name: 'tax_VAT_price')
  double? taxVATPrice;

  CreateBookingObject(
      {this.bookingAddress,
      this.workingTime = 0,
      this.serviceId,
      this.scheduledAt,
      this.description,
      this.note,
      this.bookingFiles,
      this.additionalServices,
      this.promotionId,
      this.tempPromotionId,
      this.iportalId,
      this.serviceItemId,
      this.address,
      this.serviceItems,
      this.paymentMethodId,
      this.locale,
      this.vnpReturnUrl,
      this.momoRedirectUrl,
      this.certificateRequired,
      this.referencePackage,
      this.total,
      this.serviceCharge,
      this.feePrice,
      this.personalTaxPrice,
      this.taxVATPrice});

  factory CreateBookingObject.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingObjectFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBookingObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookingPromotion {
  double? amount;
  @JsonKey(name: 'promotion_id')
  String? promotionId;

  BookingPromotion({
    this.amount,
    this.promotionId,
  });

  factory BookingPromotion.fromJson(Map<String, dynamic> json) =>
      _$BookingPromotionFromJson(json);

  Map<String, dynamic> toJson() => _$BookingPromotionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateBookingAddressData {
  @JsonKey(name: 'contact_name')
  String? contactName;
  @JsonKey(name: 'phone_code')
  int? phoneCode;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  String? type;
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
  @JsonKey(name: 'address_name')
  String? addressName;
  String? street;
  double? latitude;
  double? longitude;
  String? id;
  @JsonKey(name: 'full_address')
  String? fullAddress;

  CreateBookingAddressData({
    this.contactName,
    this.phoneCode,
    this.phoneNumber,
    this.type,
    this.provinceCode,
    this.provinceName,
    this.districtCode,
    this.districtName,
    this.wardCode,
    this.wardName,
    this.street,
    this.latitude,
    this.longitude,
    this.addressName,
    this.id,
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

  String get fullAddressDescriptionWithAddressName {
    if ((street == null || street!.isEmpty) && fullAddress != null) {
      return '$addressName - $fullAddress';
    }
    return '''$addressName - ${[
      street,
      wardName,
      districtName,
      provinceName
    ].where((element) => element != null && element.isNotEmpty == true).join(', ')}''';
  }

  factory CreateBookingAddressData.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingAddressDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBookingAddressDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateBookingAddressPosition {
  String type;
  List<double>? coordinates;

  CreateBookingAddressPosition({
    this.type = AddressPositionType.point,
    this.coordinates,
  });

  factory CreateBookingAddressPosition.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingAddressPositionFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBookingAddressPositionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateBookingFiles {
  List<CreateBookingFile>? data;

  CreateBookingFiles({
    this.data,
  });

  factory CreateBookingFiles.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingFilesFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBookingFilesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateBookingFile {
  String? url;
  @JsonKey(name: 'mime_type')
  String? mimeType;
  String? name;

  CreateBookingFile({
    this.url,
    this.mimeType,
    this.name,
  });

  factory CreateBookingFile.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingFileFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBookingFileToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateBookingAdditionalServices {
  List<CreateBookingAdditionalService>? data;

  CreateBookingAdditionalServices({
    this.data,
  });

  factory CreateBookingAdditionalServices.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingAdditionalServicesFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateBookingAdditionalServicesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateBookingAdditionalService {
  @JsonKey(name: 'additional_service_id')
  String? additionalServiceId;
  int quantity;

  CreateBookingAdditionalService({
    this.additionalServiceId,
    this.quantity = 1,
  });

  factory CreateBookingAdditionalService.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingAdditionalServiceFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBookingAdditionalServiceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateBookingResult {
  String? id;
  @JsonKey(name: 'vnpay_payment_url')
  String? vnpayPaymentUrl;
  @JsonKey(name: 'momo_deep_link')
  String? momoDeepLink;

  CreateBookingResult(this.id, this.vnpayPaymentUrl, this.momoDeepLink);

  factory CreateBookingResult.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingResultFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBookingResultToJson(this);
}
