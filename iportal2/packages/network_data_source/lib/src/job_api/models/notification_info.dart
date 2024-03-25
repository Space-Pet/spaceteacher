class NotificationInfo {
  late String description;
  late String verb;
  late DateTime timestamp;
  late int id;
  late bool unread;
  late String model;
  late String targetObjectId;

  NotificationInfo(
      {
        required this.description,
        required this.verb,
        required this.timestamp,
        required this.id,
        required this.unread,
        required this.model,
        required this.targetObjectId
      });

  NotificationInfo.fromJson(Map<String, dynamic> json) {
    description = json['description'] ?? '';
    verb = json['verb'] ?? '';
    timestamp = json['timestamp'] != null ? DateTime.tryParse(json['timestamp']) ?? DateTime.now() : DateTime.now();
    id = json['id'] ?? 0;
    unread = json['unread'] ?? false;
    model = json['model'] ?? '';
    targetObjectId = json['target_object_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['verb'] = verb;
    return data;
  }
}
