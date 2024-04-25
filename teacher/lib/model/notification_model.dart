import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/link_model.dart';
import 'package:teacher/model/meta_model.dart';
import 'package:teacher/model/notification_detail_model.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: 'data')
  final List<NotificationDetailModel>? listNotification;
  final Links? links;
  final Meta? meta;

  NotificationModel({
    this.listNotification,
    this.links,
    this.meta,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  String toString() {
    return 'Notification{listNotification: $listNotification, links: $links, meta: $meta}';
  }

  NotificationModel copyWith({
    List<NotificationDetailModel>? listNotification,
    Links? links,
    Meta? meta,
  }) {
    return NotificationModel(
      listNotification: listNotification ?? this.listNotification,
      links: links ?? this.links,
      meta: meta ?? this.meta,
    );
  }
}
