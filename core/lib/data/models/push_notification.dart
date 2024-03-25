import 'package:json_annotation/json_annotation.dart';

part 'push_notification.g.dart';

@JsonSerializable()
class PushNotification {
  PushNotification(
      {this.notificationId,
      this.title,
      this.message,
      this.caseId,
      this.type,
      this.read = false,
      this.conversationId,
      this.createdAt});

  @JsonKey(name: 'notification_id')
  String? notificationId;

  String? title;
  String? message;
  DateTime? createdAt;

  @JsonKey(name: 'case_id')
  String? caseId;

  String? type;

  String? conversationId;

  @JsonKey(defaultValue: false)
  bool read;

  factory PushNotification.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$PushNotificationToJson(this);
}
