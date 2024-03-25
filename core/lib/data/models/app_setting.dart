import 'package:json_annotation/json_annotation.dart';

import '../../common/client_info.dart';
import '../../common/utils/common_function.dart';

part 'app_setting.g.dart';

@JsonSerializable(explicitToJson: true)
class AppSetting {
  @JsonKey(name: 'max_upload_count')
  double? maxUploadCount;
  @JsonKey(name: 'partner_profile_info')
  String? partnerProfileInfo;
  @JsonKey(name: 'max_upload_size')
  double? maxUploadSize;
  @JsonKey(name: 'hotline')
  String? hotline;
  @JsonKey(name: 'locales')
  List<String>? locales;
  @JsonKey(name: 'term_of_use')
  TermOfUse? termOfUse;
  @JsonKey(name: 'partner_term_of_use')
  TermOfUse? partnerTermOfUse;
  @JsonKey(name: 'transfer_fee')
  String? transferFee;
  @JsonKey(name: 'booking_reminder')
  String? bookingReminder;
  @JsonKey(name: 'withdraw_fee')
  String? withdrawFee;
  @JsonKey(name: 'defined_questions')
  List<DefinedQuestions>? definedQuestions;
  @JsonKey(name: 'partner_defined_questions')
  List<DefinedQuestions>? partnerDefinedQuestions;
  @JsonKey(name: 'min_balance')
  String? minBalance;
  @JsonKey(name: 'min_warning')
  String? minWarning;
  @JsonKey(name: 'store_distance')
  String? storeDistance;
  @JsonKey(name: 'appVersion')
  List<AppVersion>? appVersion;
  @JsonKey(name: 'version_app_review')
  String? versionAppReview;
  @JsonKey(name: 'phone_number_app_review')
  String? phoneNumberAppReview;
  @JsonKey(name: 'in_app_review')
  bool? inAppReview;
  @JsonKey(name: 'zalo_link')
  String? zaloLink;
  @JsonKey(name: 'topup_banking_information')
  String? topupBankingInformation;
  @JsonKey(name: 'company_information')
  Content? companyInformation;

  AppSetting();

  bool isCurrentlyInAppReview() {
    return inAppReview == true &&
        CommonFunction.isTheSameVersion(
          versionAppReview ?? '',
          ClientInfo.appVersionName,
        );
  }

  factory AppSetting.fromJson(Map<String, dynamic> json) =>
      _$AppSettingFromJson(json);

  Map<String, dynamic> toJson() => _$AppSettingToJson(this);
}

@JsonSerializable()
class AppSettingResponse {
  @JsonKey(name: 'app_settings')
  AppSetting? appSettings;

  AppSettingResponse();

  factory AppSettingResponse.fromJson(Map<String, dynamic> json) =>
      _$AppSettingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppSettingResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TermOfUse {
  Content? content;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  TermOfUse({
    this.content,
    this.updatedAt,
  });

  factory TermOfUse.fromJson(Map<String, dynamic> json) =>
      _$TermOfUseFromJson(json);

  Map<String, dynamic> toJson() => _$TermOfUseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  String? vi;
  String? en;

  Content({this.vi, this.en});

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DefinedQuestions {
  Content? reply;
  bool? disabled;
  Content? key;

  DefinedQuestions({
    this.reply,
    this.disabled,
    this.key,
  });

  factory DefinedQuestions.fromJson(Map<String, dynamic> json) =>
      _$DefinedQuestionsFromJson(json);

  Map<String, dynamic> toJson() => _$DefinedQuestionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AppVersion {
  String? type;
  CurrentVersion? ios;
  CurrentVersion? android;

  AppVersion({
    this.type,
    this.ios,
    this.android,
  });

  factory AppVersion.fromJson(Map<String, dynamic> json) =>
      _$AppVersionFromJson(json);

  Map<String, dynamic> toJson() => _$AppVersionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CurrentVersion {
  String? version;
  @JsonKey(name: 'required')
  bool? isRequired;

  CurrentVersion({
    this.version,
    this.isRequired,
  });

  factory CurrentVersion.fromJson(Map<String, dynamic> json) =>
      _$CurrentVersionFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentVersionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TermsOfUse {
  Content? content;
  String? id;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  Content? name;
  String? status;
  Content? description;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  TermsOfUse(
      {this.content,
      this.id,
      this.imageUrl,
      this.name,
      this.status,
      this.description,
      this.updatedAt});
  factory TermsOfUse.fromJson(Map<String, dynamic> json) =>
      _$TermsOfUseFromJson(json);

  Map<String, dynamic> toJson() => _$TermsOfUseToJson(this);
}
