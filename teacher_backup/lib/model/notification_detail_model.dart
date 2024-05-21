import 'package:json_annotation/json_annotation.dart';
part 'notification_detail_model.g.dart';

@JsonSerializable()
class NotificationDetailModel {
  final int? id;
  @JsonKey(name: 'school_id')
  final int? schoolID;
  final String? title;
  final String? content;
  final String? attachment;
  @JsonKey(name: 'viewer_id')
  final String? viewerID;
  @JsonKey(name: 'pupil_id')
  final int? pupilID;
  @JsonKey(name: 'to_user_id')
  final String? toUserID;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'viewed_at')
  final String? viewedAt;
  @JsonKey(name: 'created_by')
  final int? createdBy;

  NotificationDetailModel({
    this.id,
    this.schoolID,
    this.title,
    this.content,
    this.attachment,
    this.viewerID,
    this.pupilID,
    this.toUserID,
    this.createdAt,
    this.updatedAt,
    this.viewedAt,
    this.createdBy,
  });

  factory NotificationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDetailModelToJson(this);

  @override
  String toString() {
    return 'NotificationDetail{id: $id, schoolID: $schoolID, title: $title, content: $content, attachment: $attachment, viewerID: $viewerID, pupilID: $pupilID, toUserID: $toUserID, createdAt: $createdAt, updatedAt: $updatedAt, viewedAt: $viewedAt, createdBy: $createdBy}';
  }

  NotificationDetailModel copyWith({
    int? id,
    int? schoolID,
    String? title,
    String? content,
    String? attachment,
    String? viewerID,
    int? pupilID,
    String? toUserID,
    String? createdAt,
    String? updatedAt,
    String? viewedAt,
    int? createdBy,
  }) {
    return NotificationDetailModel(
      id: id ?? this.id,
      schoolID: schoolID ?? this.schoolID,
      title: title ?? this.title,
      content: content ?? this.content,
      attachment: attachment ?? this.attachment,
      viewerID: viewerID ?? this.viewerID,
      pupilID: pupilID ?? this.pupilID,
      toUserID: toUserID ?? this.toUserID,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      viewedAt: viewedAt ?? this.viewedAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
