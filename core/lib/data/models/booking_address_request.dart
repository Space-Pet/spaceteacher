import 'package:json_annotation/json_annotation.dart';

part 'booking_address_request.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingAddressRequest {
  @JsonKey(name: 'address_name')
  String? addressName;
  @JsonKey(name: 'contact_name')
  String? contactName;
  @JsonKey(name: 'phone_code')
  int? phoneCode;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  @JsonKey(name: 'type')
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
  @JsonKey(name: 'street')
  String? street;
  String? id;
  @JsonKey(name: 'account_id')
  String? accountId;
  @JsonKey(name: 'full_address')
  String? fullAddress;
  double? latitude;
  double? longitude;

  BookingAddressRequest({
    this.addressName,
    this.contactName,
    this.wardName,
    this.districtName,
    this.provinceName,
    this.phoneNumber,
    this.phoneCode,
    this.districtCode,
    this.wardCode,
    this.street,
    this.provinceCode,
    this.type,
    this.id,
    this.accountId,
    this.fullAddress,
    this.latitude,
    this.longitude,
  });

  factory BookingAddressRequest.fromJson(Map<String, dynamic> json) =>
      _$BookingAddressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BookingAddressRequestToJson(this);
}
