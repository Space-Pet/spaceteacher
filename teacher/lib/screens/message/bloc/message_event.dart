part of 'message_bloc.dart';

sealed class MessageEvent {}

class GetListMessage extends MessageEvent {}

class GetListMessageResert extends MessageEvent {}

class GetPhoneBookStudent extends MessageEvent {}

class GetMessageDetail extends MessageEvent {
  final String conversationId;
  final int page;
  GetMessageDetail({required this.conversationId, this.page = 1});
  List<Object> get props => [conversationId, page];
}

class PostMessage extends MessageEvent {
  final String content;
  final String recipient;
  PostMessage({required this.content, required this.recipient});
  List<Object> get props => [content, recipient];
}

class GetMessageDetailRestart extends MessageEvent {
  final String conversationId;
  final int page;
  GetMessageDetailRestart({required this.conversationId, this.page = 1});
  List<Object> get props => [conversationId, page];
}

class DeleteMessageDetail extends MessageEvent {
  final String content;
  final String recipient;
  final int idMessage;
  DeleteMessageDetail({
    required this.content,
    required this.idMessage,
    required this.recipient,
  });
  List<Object> get props => [content, idMessage, recipient];
}

class DeleteMessage extends MessageEvent {
  final int idMessage;
  DeleteMessage({
    required this.idMessage,
  });
  List<Object> get props => [
        idMessage,
      ];
}

class PinMessage extends MessageEvent {
  final int idMessage;
  PinMessage({required this.idMessage});
  List<Object> get props => [
        idMessage,
      ];
}

class DeletePinMessage extends MessageEvent {
  final int idMessage;
  DeletePinMessage({required this.idMessage});
  List<Object> get props => [
        idMessage,
      ];
}

class GetPinMessage extends MessageEvent {}
