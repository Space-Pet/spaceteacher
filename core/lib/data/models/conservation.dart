import 'package:freezed_annotation/freezed_annotation.dart';
part 'conservation.g.dart';

@JsonSerializable()
class Conservation {
  final int? id;
  @JsonKey(name: 'sender_id')
  final int? senderId;
  @JsonKey(name: 'receiver_id')
  final int? receiverId;
  @JsonKey(name: 'conversation_id')
  final int? conversationId;
  final String? content;
  @JsonKey(name: 'user_type')
  final int? userType;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @JsonKey(name: 'un_read')
  final int? unRead;
  @JsonKey(name: 'created_at')
  final String? createAt;

  const Conservation({
    this.id,
    this.senderId,
    this.receiverId,
    this.conversationId,
    this.content,
    this.userType,
    this.fullName,
    this.avatarUrl,
    this.unRead,
    this.createAt,
  });

  factory Conservation.fromJson(Map<String, dynamic> json) =>
      _$ConservationFromJson(json);

  factory Conservation.empty() => const Conservation(
        id: 0,
        senderId: 0,
        receiverId: 0,
        conversationId: 0,
        content: '',
        userType: 0,
        fullName: '',
        avatarUrl: '',
        unRead: 0,
        createAt: '',
      );

  Map<String, dynamic> toJson() => _$ConservationToJson(this);

  static List<Conservation> fakeData() => List.generate(
        10,
        (index) => Conservation(
          id: index,
          senderId: index,
          receiverId: index,
          conversationId: index,
          content: 'content $index',
          userType: index,
          fullName: 'fullName $index',
          avatarUrl: 'avatarUrl $index',
          unRead: index,
          createAt: '2024-06-23T22:30:15.000000Z',
        ),
      );

  Conservation copyWith({
    int? id,
    int? senderId,
    int? receiverId,
    int? conversationId,
    String? content,
    int? userType,
    String? fullName,
    String? avatarUrl,
    int? unRead,
    String? createAt,
  }) {
    return Conservation(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      conversationId: conversationId ?? this.conversationId,
      content: content ?? this.content,
      userType: userType ?? this.userType,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      unRead: unRead ?? this.unRead,
      createAt: createAt ?? this.createAt,
    );
  }
}
