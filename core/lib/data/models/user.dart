import 'package:enum_to_string/enum_to_string.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils.dart';
import 'address.dart';

part 'user.g.dart';

enum AccountStatus { blocked, active, deleted, block }

@JsonSerializable(explicitToJson: true)
class User {
  String? id;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'display_name')
  String? displayName;
  DateTime? birthday;
  String? email;
  @JsonKey(name: 'phone_code')
  int? phoneCode;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  List<Address>? addresses;
  @JsonKey(name: 'avatar_url')
  String? avatarURL;
  String? role;
  @JsonKey(name: 'conversation_id')
  String? conversationId;
  @JsonKey(name: 'teacher_status')
  String? teacherStatus;
  @JsonKey(name: 'fixed_rate')
  num? fixedRate;
  String? gender;
  Account? account;
  @JsonKey(name: 'partner_code')
  String? partnerCode;
  PartnerStatistic? stats;
  List<Services>? services;
  @JsonKey(name: 'created_at')
  String? createdAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.displayName,
    this.birthday,
    this.email,
    this.phoneCode,
    this.phoneNumber,
    this.addresses,
    this.avatarURL,
    this.conversationId,
    this.teacherStatus,
    this.fixedRate,
    this.gender,
    this.createdAt,
    this.services,
  });

  User copyWith({
    String? phoneNumber,
    String? avatarURL,
    String? firstName,
    String? lastName,
    String? email,
    DateTime? birthday,
    List<Address>? addresses,
    String? gender,
  }) {
    return User(
      id: id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      addresses: addresses ?? this.addresses,
      avatarURL: avatarURL ?? this.avatarURL,
      gender: gender ?? this.gender,
    );
  }

  String get fullName {
    return [lastName, firstName].where((element) => element != null).join(' ');
  }

  String get displayAge {
    if (birthday == null) {
      return '';
    }
    return CommonFunction.calculateAge(birthday!).toString();
  }

   String? getName(String languageCode) {
    final string = [];
    for (final e in services ?? <Services>[]) {
      string.add(e.service?.name(languageCode));
    }

    return string.join(', ');
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class AccountRole {
  String? status;
  String? role;

  @JsonKey(name: 'account_addresses')
  List<dynamic>? accountAddresses;

  AccountRole(this.status, this.accountAddresses, this.role);

  factory AccountRole.fromJson(Map<String, dynamic> json) =>
      _$AccountRoleFromJson(json);

  Map<String, dynamic> toJson() => _$AccountRoleToJson(this);

  AccountStatus? get enumStatus {
    try {
      return EnumToString.fromString(
        AccountStatus.values,
        status ?? '',
      );
    } catch (e) {
      return null;
    }
  }
}

@JsonSerializable()
class Services {
  PartnerService? service;

  Services({this.service});

  factory Services.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PartnerRating {
  @JsonKey(name: 'partner_id')
  String? partnerId;
  double? rating;

  PartnerRating({
    this.partnerId,
    this.rating,
  });

  factory PartnerRating.fromJson(Map<String, dynamic> json) =>
      _$PartnerRatingFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerRatingToJson(this);
}

@JsonSerializable()
class Account {
  String? id;

  Account(this.id);

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
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
