import 'package:json_annotation/json_annotation.dart';

import 'localization_model.dart';

part 'booking_address_type.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingAddressType {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'hourly_charge')
  num? hourlyCharge;
  @JsonKey(name: 'description')
  LocalizationModel? description;

  BookingAddressType();

  factory BookingAddressType.fromJson(Map<String, dynamic> json) =>
      _$BookingAddressTypeFromJson(json);

  Map<String, dynamic> toJson() => _$BookingAddressTypeToJson(this);
}
