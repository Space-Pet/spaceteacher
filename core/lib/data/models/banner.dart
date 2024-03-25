import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';

@JsonSerializable()
class BannerModel {
  String? id;
  String? name;
  @JsonKey(name: 'media_url')
  String? mediaUrl;
  @JsonKey(name: 'mime_type')
  String? mimeType;
  String? url;
  @JsonKey(name: 'subject_id')
  String? subjectId;
  @JsonKey(name: 'subject_type')
  String? subjectType;

  BannerModel({
    this.id,
    this.name,
    this.mediaUrl,
    this.mimeType,
    this.url,
    this.subjectId,
    this.subjectType,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
