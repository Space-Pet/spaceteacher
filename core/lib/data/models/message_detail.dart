import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_detail.g.dart';

@JsonSerializable()
class MessageDetail {
  final int? id;
  final String? content;
  @JsonKey(name: 'attachments')
  final List<AtthachmentMessageDetail>? attachments;
  @JsonKey(name: 'school_id')
  final int? schoolId;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'user_type')
  final int? userType;
  final int? recipient;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @JsonKey(name: 'viewed_at')
  final String? viewedAt;
  @JsonKey(name: 'conversation_id')
  final int? conversationId;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final int? sticky;

  const MessageDetail({
    this.avatarUrl,
    this.content,
    this.attachments,
    this.fullName,
    this.id,
    this.recipient,
    this.schoolId,
    this.userId,
    this.userType,
    this.viewedAt,
    this.conversationId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.sticky,
  });

  factory MessageDetail.fromJson(Map<String, dynamic> json) =>
      _$MessageDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDetailToJson(this);

  factory MessageDetail.empty() => const MessageDetail(
        id: 0,
        content: '',
        attachments: [],
        schoolId: 0,
        userId: 0,
        userType: 0,
        recipient: 0,
        fullName: '',
        avatarUrl: '',
        viewedAt: '',
        conversationId: 0,
        createdBy: '',
        createdAt: '',
        updatedAt: '',
        sticky: 0,
      );

  static List<MessageDetail> fakeData() {
    return List.generate(
      10,
      (index) => MessageDetail(
        id: index,
        content: 'content $index',
        attachments: [],
        schoolId: index,
        userId: index,
        userType: index,
        recipient: index,
        fullName: 'fullName $index',
        avatarUrl: 'avatarUrl $index',
        viewedAt: 'viewedAt $index',
        conversationId: index,
        createdBy: 'createdBy $index',
        createdAt: 'createdAt $index',
        updatedAt: 'updatedAt $index',
        sticky: index,
      ),
    );
  }

  MessageDetail copyWith({
    int? id,
    String? content,
    List<AtthachmentMessageDetail>? attachments,
    int? schoolId,
    int? userId,
    int? userType,
    int? recipient,
    String? fullName,
    String? avatarUrl,
    String? viewedAt,
    int? conversationId,
    String? createdBy,
    String? createdAt,
    String? updatedAt,
    int? sticky,
  }) {
    return MessageDetail(
      id: id ?? this.id,
      content: content ?? this.content,
      attachments: attachments ?? this.attachments,
      schoolId: schoolId ?? this.schoolId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      recipient: recipient ?? this.recipient,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      viewedAt: viewedAt ?? this.viewedAt,
      conversationId: conversationId ?? this.conversationId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sticky: sticky ?? this.sticky,
    );
  }
}

@JsonSerializable()
class AtthachmentMessageDetail {
  final int? id;
  @JsonKey(name: 'resource_id')
  final int? resourceId;
  final String? url;
  @JsonKey(name: 'file_type')
  final String? fileType;

  const AtthachmentMessageDetail({
    this.fileType,
    this.id,
    this.resourceId,
    this.url,
  });

  factory AtthachmentMessageDetail.fromJson(Map<String, dynamic> json) =>
      _$AtthachmentMessageDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AtthachmentMessageDetailToJson(this);

  @override
  String toString() {
    return 'AtthachmentMessageDetail{id: $id, resourceId: $resourceId, url: $url, fileType: $fileType}';
  }

  AtthachmentMessageDetail copyWith({
    int? id,
    int? resourceId,
    String? url,
    String? fileType,
  }) {
    return AtthachmentMessageDetail(
      id: id ?? this.id,
      resourceId: resourceId ?? this.resourceId,
      url: url ?? this.url,
      fileType: fileType ?? this.fileType,
    );
  }
}
