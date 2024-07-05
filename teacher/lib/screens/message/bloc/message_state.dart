part of 'message_bloc.dart';

enum MessageStatus {
  init,

  loadingConservationList,
  successConservationList,
  errorConservationList,

  loadingConservationDetail,
  successConservationDetail,
  errorConservationDetail,

  loadingGetNewMessage,
  successGetNewMessage,

  loadingLoadMoreMessages,
  successLoadMoreMessages,
  errorLoadMoreMessages,

  loadingSendMessage,
  successSendMessage,
  errorSendMessage,

  loadingDeleteMessage,
  successDeleteMessage,
  errorDeleteMessage,

  loadingDeleteConservation,
  successDeleteConservation,
  errorDeleteConservation,

  loadingPinMessage,
  successPinMessage,
  errorPinMessage,

  loadingUnpinMessage,
  successUnpinMessage,
  errorUnpinMessage,

  loadingGetPinMessage,
  successGetPinMessage,
  errorGetPinMessage,

  loadingGetPhoneBookStudent,
  successGetPhoneBookStudent,
}

class MessageState {
  final List<ClassTeacher> classTeacher;
  final ClassTeacher seletedClasss;

  final List<Conservation> conservationList;
  final List<ConservationDetail> conservationDetail;
  final List<PhoneBookStudent> phoneBookStudent;
  final ConservationDetail? messagePin;
  final LocalIPortalProfile? profileInfo;
  final int currentPage;
  final bool hasMoreData;
  final int? conversationID;
  final bool isFirstLoadChatRoom;

  final MessageStatus messageStatus;
  final MessageStatus messageDetailStatus;
  final MessageStatus pinStatus;

  const MessageState({
    this.classTeacher = const [],
    required this.seletedClasss,
    required this.conservationList,
    this.messagePin,
    this.profileInfo,
    required this.conservationDetail,
    this.phoneBookStudent = const [],
    this.currentPage = 1,
    this.hasMoreData = false,
    this.conversationID,
    this.isFirstLoadChatRoom = true,
    this.messageStatus = MessageStatus.init,
    this.messageDetailStatus = MessageStatus.init,
    this.pinStatus = MessageStatus.init,
  });

  List<Object?> get props => [
        classTeacher,
        seletedClasss,
        conservationDetail,
        conservationList,
        profileInfo,
        phoneBookStudent,
        messagePin,
        currentPage,
        hasMoreData,
        conversationID,
        isFirstLoadChatRoom,
        messageStatus,
        messageDetailStatus,
        pinStatus,
      ];

  MessageState copyWith({
    List<ClassTeacher>? classTeacher,
    ClassTeacher? seletedClasss,
    List<Conservation>? conservationList,
    List<ConservationDetail>? conservationDetail,
    List<PhoneBookStudent>? phoneBookStudent,
    LocalIPortalProfile? profileInfo,
    ConservationDetail? messagePin,
    int? currentPage,
    bool? hasMoreData,
    int? conversationID,
    bool? isFirstLoadChatRoom,
    MessageStatus? messageStatus,
    MessageStatus? messageDetailStatus,
    MessageStatus? pinStatus,
  }) {
    return MessageState(
      classTeacher: classTeacher ?? this.classTeacher,
      seletedClasss: seletedClasss ?? this.seletedClasss,
      conservationList: conservationList ?? this.conservationList,
      conservationDetail: conservationDetail ?? this.conservationDetail,
      messagePin: messagePin ?? this.messagePin,
      profileInfo: profileInfo ?? this.profileInfo,
      phoneBookStudent: phoneBookStudent ?? this.phoneBookStudent,
      messageStatus: messageStatus ?? this.messageStatus,
      messageDetailStatus: messageDetailStatus ?? this.messageDetailStatus,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      conversationID: conversationID ?? this.conversationID,
      isFirstLoadChatRoom: isFirstLoadChatRoom ?? this.isFirstLoadChatRoom,
      pinStatus: pinStatus ?? this.pinStatus,
    );
  }
}
