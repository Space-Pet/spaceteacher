import 'package:json_annotation/json_annotation.dart';

import '../../common/constants/app_locale.dart';

part 'localization_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LocalizationModel {
  @JsonKey(name: 'vi')
  String? vi;
  @JsonKey(name: 'en')
  String? en;

  LocalizationModel();

  String? localized(String languageCode) {
    if (languageCode == AppLocale.vi.languageCode) {
      return vi;
    }
    if (languageCode == AppLocale.en.languageCode) {
      return en;
    }
    return null;
  }

  factory LocalizationModel.fromJson(Map<String, dynamic> json) =>
      _$LocalizationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocalizationModelToJson(this);
}
