class Message {
  final int id;
  final int senderId;
  final int receiverId;
  final int conversationId;
  final String content;
  final String fullName;
  final String avatarUrl;
  final int unRead;
  final DateTime createAt;
  const Message(
      {required this.avatarUrl,
      required this.content,
      required this.conversationId,
      required this.createAt,
      required this.fullName,
      required this.id,
      required this.receiverId,
      required this.senderId,
      required this.unRead});
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        avatarUrl: json['avatar_url'] ?? '',
        content: json['content'] ?? '',
        conversationId: json['conversation_id'] ?? 0,
        createAt: DateTime.parse(json['created_at'] ?? ''),
        fullName: json['full_name'] ?? '',
        id: json['id'] ?? 0,
        receiverId: json['receiver_id'] ?? 0,
        senderId: json['sender_id'] ?? 0,
        unRead: json['un_read'] ?? 0);
  }
  factory Message.empty() => Message(
      avatarUrl: '',
      content: '',
      conversationId: 0,
      createAt: DateTime.now(),
      fullName: '',
      id: 0,
      receiverId: 0,
      senderId: 0,
      unRead: 0);
}
