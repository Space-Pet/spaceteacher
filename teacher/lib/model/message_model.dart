import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  final int? id;
  @JsonKey(name: "sender_id")
  final int? senderId;
  @JsonKey(name: "receiver_id")
  final int? receiverId;
  @JsonKey(name: "conversation_id")
  final int? conversationId;
  final String? content;
  @JsonKey(name: "user_type")
  final int? userType;
  @JsonKey(name: "full_name")
  final String? fullName;
  @JsonKey(name: "avatar_url")
  final String? avatarUrl;
  @JsonKey(name: "un_read")
  final int? unRead;
  @JsonKey(name: "created_at")
  final String? createdAt;

  MessageModel({
    this.id,
    this.senderId,
    this.receiverId,
    this.conversationId,
    this.content,
    this.userType,
    this.fullName,
    this.avatarUrl,
    this.unRead,
    this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  MessageModel copyWith({
    int? id,
    int? senderId,
    int? receiverId,
    int? conversationId,
    String? content,
    int? userType,
    String? fullName,
    String? avatarUrl,
    int? unRead,
    String? createdAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      conversationId: conversationId ?? this.conversationId,
      content: content ?? this.content,
      userType: userType ?? this.userType,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      unRead: unRead ?? this.unRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'MessageModel(id: $id, senderId: $senderId, receiverId: $receiverId, conversationId: $conversationId, content: $content, userType: $userType, fullName: $fullName, avatarUrl: $avatarUrl, unRead: $unRead, createdAt: $createdAt)';
  }
}
