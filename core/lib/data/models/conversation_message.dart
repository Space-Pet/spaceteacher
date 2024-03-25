import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'conversation_message.g.dart';

@JsonSerializable(explicitToJson: true)
class ConversationMessage {
  String? content;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'content_data')
  ContentData? contentData;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  String? type;
  @JsonKey(ignore: true)
  File? file;
  ChatMember? member;

  ConversationMessage(
      {this.content,
      this.userId,
      this.contentData,
      this.createdAt,
      this.type,
      this.file,
      this.member});

  factory ConversationMessage.fromJson(Map<String, dynamic> json) =>
      _$ConversationMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationMessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChatMember {
  @JsonKey(name: 'read_at')
  DateTime? readAt;

  ChatMember({this.readAt});

  factory ChatMember.fromJson(Map<String, dynamic> json) =>
      _$ChatMemberFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMemberToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ContentData {
  String? url;
  String? thumbnail;
  String? ratio;

  ContentData({this.url, this.thumbnail, this.ratio});

  factory ContentData.fromJson(Map<String, dynamic> json) =>
      _$ContentDataFromJson(json);

  Map<String, dynamic> toJson() => _$ContentDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class QuickMessage {
  String? id;
  Content? content;
  int? priority;
  String? type;

  QuickMessage({this.id, this.content, this.priority, this.type});

  factory QuickMessage.fromJson(Map<String, dynamic> json) =>
      _$QuickMessageFromJson(json);

  Map<String, dynamic> toJson() => _$QuickMessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  String? en;
  String? vi;

  Content({this.en, this.vi});

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
