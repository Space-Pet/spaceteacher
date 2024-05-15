import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/link_model.dart';
import 'package:teacher/model/message_detail_model.dart';
import 'package:teacher/model/meta_model.dart';

part 'conversation_detail_model.g.dart';

@JsonSerializable()
class ConversationDetailModel {
  @JsonKey(name: "data")
  final List<MessageDetailModel>? messages;
  final Links? links;
  final Meta? meta;

  ConversationDetailModel({
    this.messages,
    this.links,
    this.meta,
  });

  factory ConversationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationDetailModelToJson(this);

  ConversationDetailModel copyWith({
    List<MessageDetailModel>? messages,
    Links? links,
    Meta? meta,
  }) {
    return ConversationDetailModel(
      messages: messages ?? this.messages,
      links: links ?? this.links,
      meta: meta ?? this.meta,
    );
  }

  @override
  String toString() {
    return 'ConversationDetailModel{messages: $messages, links: $links, meta: $meta}';
  }
}
