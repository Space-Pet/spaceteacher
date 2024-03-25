import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils.dart';
import '../../presentation/extentions/extention.dart';
import 'booking_address_type.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  String? id;
  @JsonKey(name: 'country_code')
  String? countryCode;
  @JsonKey(name: 'district_code')
  String? districtCode;
  @JsonKey(name: 'district_name')
  String? districtName;
  @JsonKey(name: 'province_code')
  String? provinceCode;
  @JsonKey(name: 'province_name')
  String? provinceName;
  @JsonKey(name: 'ward_code')
  String? wardCode;
  @JsonKey(name: 'ward_name')
  String? wardName;
  @JsonKey(name: 'street')
  String? street;
  @JsonKey(name: 'full_address')
  String? fullAddress;
  @JsonKey(name: 'address_name')
  String? addressName;
  @JsonKey(name: 'contact_name')
  String? contactName;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  @JsonKey(name: 'phone_code')
  int? phoneCode;
  @JsonKey(name: 'address_type')
  BookingAddressType? addressType;
  @JsonKey(name: 'type')
  String? type;
  Position? position;

  Address({
    this.id,
    this.countryCode,
    this.districtCode,
    this.districtName,
    this.provinceCode,
    this.provinceName,
    this.wardCode,
    this.wardName,
    this.street,
    this.fullAddress,
    this.addressType,
    this.type,
    this.contactName,
    this.phoneNumber,
    this.position,
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
    if(street == null || street!.isEmpty) {
      return '$addressName - $fullAddress';
    }
    return '''$addressName - ${[
      street,
      wardName,
      districtName,
      provinceName
    ].where((element) => element != null && element.isNotEmpty == true).join(', ')}''';
  }

  String get shortAddressDescription {
    return [street, wardName, districtName]
        .where((element) => element != null && element.isNotEmpty == true)
        .join(', ');
  }

  Future<List<double>?> getLocationFromAddress(
      BuildContext context, dynamic trans) async {
    try {
      final locations =
          await geocoding.locationFromAddress(fullAddressDescription);
      final location = locations.firstOrNull;
      if (location == null) {
        return null;
      }
      return [
        location.longitude,
        location.latitude,
      ];
    } catch (e) {
      if (e is PlatformException && e.message?.contains('network') == true) {
        unawaited(showNoticeErrorDialog(
          context: context,
          message: trans.noConnection,
          trans: trans,
        ));
      }
      return null;
    }
  }

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

class AddressRequest {
  String? accountId;
  final String? countryCode;
  final String? districtCode;
  final String? districtName;
  final String? provinceCode;
  final String? provinceName;
  final String? wardCode;
  final String? wardName;
  final String? street;

  AddressRequest({
    this.accountId,
    required this.countryCode,
    required this.districtCode,
    required this.districtName,
    required this.provinceCode,
    required this.provinceName,
    required this.wardCode,
    required this.wardName,
    required this.street,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'country_code': countryCode,
      'district_code': districtCode,
      'district_name': districtName,
      'province_code': provinceCode,
      'province_name': provinceName,
      'ward_code': wardCode,
      'ward_name': wardName,
      'street': street,
    };
  }
}

@JsonSerializable(explicitToJson: true)
class Position {
  String? type;
  Crs? crs;
  List<double>? coordinates;

  Position({this.type, this.crs, this.coordinates});

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);
    
  Map<String, dynamic> toJson() => _$PositionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Crs {
  String? type;
  Properties? properties;

  Crs({this.type, this.properties});

  factory Crs.fromJson(Map<String, dynamic> json) => _$CrsFromJson(json);

  Map<String, dynamic> toJson() => _$CrsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Properties {
  String? name;

  Properties({this.name});

  factory Properties.fromJson(Map<String, dynamic> json) =>
      _$PropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesToJson(this);
}
