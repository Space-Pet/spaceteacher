import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/link_model.dart';
import 'package:teacher/model/message_model.dart';
import 'package:teacher/model/meta_model.dart';

part 'conversation_model.g.dart';

@JsonSerializable()
class ConversationModel {
  @JsonKey(name: "data")
  final List<MessageModel>? messages;
  final Links? links;
  final Meta? meta;

  ConversationModel({
    this.messages,
    this.links,
    this.meta,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);

  ConversationModel copyWith({
    List<MessageModel>? messages,
    Links? links,
    Meta? meta,
  }) {
    return ConversationModel(
      messages: messages ?? this.messages,
      links: links ?? this.links,
      meta: meta ?? this.meta,
    );
  }

  @override
  String toString() {
    return 'ConversationModel{messages: $messages, links: $links, meta: $meta}';
  }
}
