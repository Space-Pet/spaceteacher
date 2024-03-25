import 'package:json_annotation/json_annotation.dart';

import 'localization_model.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  String? id;
  NotificationMetadata? data;
  LocalizationModel? contents;
  LocalizationModel? headings;
  @JsonKey(name: 'subject_type')
  String? subjectType;
  @JsonKey(name: 'subject_id')
  String? subjectId;
  @JsonKey(name: 'send_after')
  DateTime? sendAfter;
  @JsonKey(name: 'booking_id')
  String? bookingId;
  bool? read;
  @JsonKey(name: 'notification_id')
  String? notificationId;

  NotificationModel({
    this.id,
    this.data,
    this.contents,
    this.subjectType,
    this.sendAfter,
    this.read,
    this.bookingId,
    this.subjectId,
    this.notificationId,
    this.headings,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class NotificationMetadata {
  @JsonKey(name: 'booking_id')
  String? bookingId;
  @JsonKey(name: 'promotion_id')
  String? promotionId;
  String? en;
  String? vi;

  NotificationMetadata(this.bookingId, this.promotionId, this.en, this.vi);

  factory NotificationMetadata.fromJson(Map<String, dynamic> json) =>
      _$NotificationMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationMetadataToJson(this);
}
