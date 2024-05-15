part of 'conversation_detail_bloc.dart';

abstract class ConversationDetailEvent extends Equatable {
  const ConversationDetailEvent();
}

class ConversationDetailEventFetch extends ConversationDetailEvent {
  const ConversationDetailEventFetch({required this.conversationId});
  final int conversationId;
  @override
  // TODO: implement props
  List<Object?> get props => [conversationId];
}

class ConversationDetailEventLoadMore extends ConversationDetailEvent {
  const ConversationDetailEventLoadMore(
      {required this.conversationId, required this.page});
  final int conversationId;
  final int page;
  @override
  // TODO: implement props
  List<Object?> get props => [conversationId, page];
}

class ConversationDetailEventRefresh extends ConversationDetailEvent {
  const ConversationDetailEventRefresh({required this.conversationId});
  final int conversationId;
  @override
  // TODO: implement props
  List<Object?> get props => [conversationId];
}

class ConversationDetailEventSendMessage extends ConversationDetailEvent {
  const ConversationDetailEventSendMessage(
      {required this.message,
      required this.classId,
      required this.listRecipient});
  final String message;
  final int classId;
  final List<int> listRecipient;
  @override
  // TODO: implement props
  List<Object?> get props => [message, classId, listRecipient];
}

class ConversationDetailEventDeleteMessage extends ConversationDetailEvent {
  const ConversationDetailEventDeleteMessage({required this.messageId});
  final int messageId;
  @override
  // TODO: implement props
  List<Object?> get props => [messageId];
}
