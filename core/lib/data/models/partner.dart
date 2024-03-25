import 'package:json_annotation/json_annotation.dart';
import 'package:core/data/models/position.dart';
import '../../common/utils.dart';
import 'adminstrative.dart';
import 'partner_files.dart';

part 'partner.g.dart';

@JsonSerializable()
class Partner {
  String? id;
  @JsonKey(name: 'avatar_url')
  String? avatarURL;
  @JsonKey(name: 'partner_profile')
  PartnerProfile? profile;
  String? email;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  Partner({
    this.id,
    this.avatarURL,
    this.profile,
    this.email,
    this.phoneNumber,
  });
Partner copyWith({
    String? avatarURL,
  }) {
    return Partner(     
      avatarURL: avatarURL ?? this.avatarURL,
    );
  }
  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerToJson(this);
}

@JsonSerializable()
class PartnerProfile {
  @JsonKey(name: 'display_name')
  String? displayName;
  String? street;
  @JsonKey(name: 'ward_name')
  String? wardName;
  @JsonKey(name: 'district_name')
  String? districtName;
  @JsonKey(name: 'province_name')
  String? provinceName;
  String? verified;
  bool? online;
  @JsonKey(name: 'partner_code')
  String? partnerCode;
  PartnerStatistic? stats;
  DateTime? birthday;
  @JsonKey(name: 'gender_info')
  PartnerGenderInfo? gender;
  List<Services>? services;
  List<PartnerWokingDistrict>? districts;
  PartnerAccount? account;
  @JsonKey(name: 'bank_account')
  String? bankAccount;
  @JsonKey(name: 'withdraw_phone_number')
  String? withdrawPhoneNumber;
  @JsonKey(name: 'bank_account_number')
  String? bankAccountNumber;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  @JsonKey(name: 'is_verified')
  bool? isVerified;
  List<Files>? files;
  @JsonKey(name: 'current_position')
  Position? currentPosition;
  

  PartnerProfile({
    this.displayName,
    this.street,
    this.wardName,
    this.districtName,
    this.provinceName,
    this.verified,
    this.online,
    this.partnerCode,
    this.stats,
    this.birthday,
    this.services,
    this.districts,
    this.account,
    this.bankAccount,
    this.bankAccountNumber,
    this.gender,
    this.phoneNumber,
    this.withdrawPhoneNumber,
    this.isVerified,
    this.files,
    this.currentPosition,
  });
  
  factory PartnerProfile.fromJson(Map<String, dynamic> json) =>
      _$PartnerProfileFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerProfileToJson(this);

  String get displayAge {
    if (birthday == null) {
      return '';
    }
    return CommonFunction.calculateAge(birthday!).toString();
  }

  String get fullAddressDescription {
    return [street, wardName, districtName, provinceName]
        .where((element) => element != null && element.isNotEmpty == true)
        .join(', ');
  }

  String get workingDistrictStr {
    return districts
            ?.map((e) => e.district?.name)
            .where((element) => element != null && element.isNotEmpty == true)
            .join(', ') ??
        '';
  }

  String? getName(String languageCode) {
    final string = [];
    for (final e in services ?? <Services>[]) {
      string.add(e.service?.name(languageCode));
    }

    return string.join(', ');
  }
}

@JsonSerializable()
class PartnerStatistic {
  @JsonKey(name: 'total_booking')
  int? totalBooking;
  double? rating;

  PartnerStatistic({
    this.totalBooking,
    this.rating,
  });

  factory PartnerStatistic.fromJson(Map<String, dynamic> json) =>
      _$PartnerStatisticFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerStatisticToJson(this);
}

@JsonSerializable()
class PartnerGenderInfo {
  @JsonKey(name: 'description')
  String? des;

  PartnerGenderInfo({
    this.des,
  });

  factory PartnerGenderInfo.fromJson(Map<String, dynamic> json) =>
      _$PartnerGenderInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerGenderInfoToJson(this);
}

@JsonSerializable()
class Services {
  PartnerService? service;

  Services({this.service});

  factory Services.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}

@JsonSerializable()
class PartnerService {
  List<PartnerServiceContent>? contents;

  PartnerService({
    this.contents,
  });

  factory PartnerService.fromJson(Map<String, dynamic> json) =>
      _$PartnerServiceFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerServiceToJson(this);

  String? name(String languageCode) {
    for (final c in contents ?? <PartnerServiceContent>[]) {
      if (c.language == languageCode) {
        return c.name;
      }
    }
    return null;
  }
}

@JsonSerializable()
class PartnerServiceContent {
  String? name;
  String? language;

  PartnerServiceContent({
    this.name,
    this.language,
  });

  factory PartnerServiceContent.fromJson(Map<String, dynamic> json) =>
      _$PartnerServiceContentFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerServiceContentToJson(this);
}

@JsonSerializable()
class PartnerWokingDistrict {
  @JsonKey(name: 'district_code')
  String? districtCode;
  District? district;

  PartnerWokingDistrict({
    this.districtCode,
    this.district,
  });

  factory PartnerWokingDistrict.fromJson(Map<String, dynamic> json) =>
      _$PartnerWokingDistrictFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerWokingDistrictToJson(this);
}

@JsonSerializable()
class PartnerAccount {
  String? id;
  @JsonKey(name: 'avatar_url')
  String? avatarURL;
  @JsonKey(name: 'phone_code')
  String? phoneCode;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  PartnerAccount({this.id, this.avatarURL, this.phoneCode, this.phoneNumber});

  factory PartnerAccount.fromJson(Map<String, dynamic> json) =>
      _$PartnerAccountFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerAccountToJson(this);
}
