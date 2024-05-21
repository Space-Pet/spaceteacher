class MessageDetail {
  final int id;
  final String content;
  final int schoolId;
  final int userId;
  final int userType;
  final int recipient;
  final String fullName;
  final String avatarUrl;
  const MessageDetail(
      {required this.avatarUrl,
      required this.content,
      required this.fullName,
      required this.id,
      required this.recipient,
      required this.schoolId,
      required this.userId,
      required this.userType});

  factory MessageDetail.fromJson(Map<String, dynamic> json) {
    return MessageDetail(
      avatarUrl: json['avatar_url'] ?? '',
      content: json['content'] ?? '',
      fullName: json['full_name'] ?? '',
      id: json['id'] ?? 0,
      recipient: json['recipient'] ?? 0,
      schoolId: json['school_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      userType: json['user_type'] ?? 0,
    );
  }
}
