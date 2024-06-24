part of 'message_bloc.dart';

enum MessageStatus {
  init,
  loading,
  success,
  error,
  loadingMessage,
  successMessage,
  loadingRestart,
  successRestart,
  loadingDelete,
  successDelete,
  loadingPostPinMessage,
  successPostPinMessage,
  loadingGetPinMessage,
  successGetPinMessage,
  loadingDeletePinMessage,
  successDeletePinMessage,
}

class MessageState {
  final List<Message> messages;
  final MessageStatus messageStatus;
  final MessageStatus roomStatus;
  final List<PhoneBookStudent> phoneBookStudent;
  final List<MessageDetail> messageDetail;
  final MessageDetail? messagePin;
  final LocalIPortalProfile? profileInfo;
  final int? currentPage;
  final bool? hasMoreData;
  final int? conversationID;
  final bool isFirstLoadChatRoom;

  const MessageState({
    this.messagePin,
    this.messages = const [],
    this.messageStatus = MessageStatus.init,
    this.roomStatus = MessageStatus.init,
    this.profileInfo,
    required this.messageDetail,
    this.phoneBookStudent = const [],
    this.currentPage = 1,
    this.hasMoreData = true,
    this.conversationID,
    this.isFirstLoadChatRoom = true,
  });

  List<Object?> get props => [
        messageDetail,
        messageStatus,
        roomStatus,
        messages,
        profileInfo,
        phoneBookStudent,
        messagePin,
        currentPage,
        hasMoreData,
        conversationID,
        isFirstLoadChatRoom,
      ];

  MessageState copyWith({
    List<Message>? messages,
    MessageStatus? messageStatus,
    MessageStatus? roomStatus,
    List<PhoneBookStudent>? phoneBookStudent,
    List<MessageDetail>? messageDetail,
    LocalIPortalProfile? profileInfo,
    MessageDetail? messagePin,
    int? currentPage,
    bool? hasMoreData,
    int? conversationID,
    bool? isFirstLoadChatRoom,
  }) {
    return MessageState(
      messagePin: messagePin ?? this.messagePin,
      profileInfo: profileInfo ?? this.profileInfo,
      messageDetail: messageDetail ?? this.messageDetail,
      phoneBookStudent: phoneBookStudent ?? this.phoneBookStudent,
      messageStatus: messageStatus ?? this.messageStatus,
      roomStatus: roomStatus ?? this.roomStatus,
      messages: messages ?? this.messages,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      conversationID: conversationID ?? this.conversationID,
      isFirstLoadChatRoom: isFirstLoadChatRoom ?? this.isFirstLoadChatRoom,
    );
  }
}
