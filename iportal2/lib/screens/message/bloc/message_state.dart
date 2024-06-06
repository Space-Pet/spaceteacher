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
  final List<PhoneBookStudent> phoneBookStudent;
  final List<MessageDetail> messageDetail;
  final MessageDetail? messagePin;
  final LocalIPortalProfile? profileInfo;
  final int? currentPage;
  final bool? hasMoreData;
  final int? conversationID;

  const MessageState({
    this.messagePin,
    this.messages = const [],
    this.messageStatus = MessageStatus.init,
    this.profileInfo,
    this.messageDetail = const [],
    this.phoneBookStudent = const [],
    this.currentPage = 1,
    this.hasMoreData = true,
    this.conversationID,
  });

  List<Object?> get props => [
        messageDetail,
        messageStatus,
        messages,
        profileInfo,
        phoneBookStudent,
        messagePin,
        currentPage,
        hasMoreData,
        conversationID
      ];
  MessageState copyWith({
    List<Message>? messages,
    MessageStatus? messageStatus,
    List<PhoneBookStudent>? phoneBookStudent,
    List<MessageDetail>? messageDetail,
    LocalIPortalProfile? profileInfo,
    MessageDetail? messagePin,
    int? currentPage,
    bool? hasMoreData,
    int? conversationID,
  }) {
    return MessageState(
      messagePin: messagePin ?? this.messagePin,
      profileInfo: profileInfo ?? this.profileInfo,
      messageDetail: messageDetail ?? this.messageDetail,
      phoneBookStudent: phoneBookStudent ?? this.phoneBookStudent,
      messageStatus: messageStatus ?? this.messageStatus,
      messages: messages ?? this.messages,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      conversationID: conversationID ?? this.conversationID,
    );
  }
}
