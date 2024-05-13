import 'package:json_annotation/json_annotation.dart';

part 'message_detail_model.g.dart';

@JsonSerializable()
class MessageDetailModel {
  final int? id;
  final String? content;
  @JsonKey(name: "school_id")
  final int? schoolId;
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "user_type")
  final int? userType;
  final int? recipient;
  @JsonKey(name: "full_name")
  final String? fullName;
  @JsonKey(name: "avatar_url")
  final String? avatarUrl;
  @JsonKey(name: "viewed_at")
  final String? viewedAt;

  MessageDetailModel({
    this.id,
    this.content,
    this.schoolId,
    this.userId,
    this.userType,
    this.recipient,
    this.fullName,
    this.avatarUrl,
    this.viewedAt,
  });

  factory MessageDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MessageDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDetailModelToJson(this);

  MessageDetailModel copyWith({
    int? id,
    String? content,
    int? schoolId,
    int? userId,
    int? userType,
    int? recipient,
    String? fullName,
    String? avatarUrl,
    String? viewedAt,
  }) {
    return MessageDetailModel(
      id: id ?? this.id,
      content: content ?? this.content,
      schoolId: schoolId ?? this.schoolId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      recipient: recipient ?? this.recipient,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      viewedAt: viewedAt ?? this.viewedAt,
    );
  }

  @override
  String toString() {
    return 'MessageDetailModel{id: $id, content: $content, schoolId: $schoolId, userId: $userId, userType: $userType, recipient: $recipient, fullName: $fullName, avatarUrl: $avatarUrl, viewedAt: $viewedAt}';
  }
}
