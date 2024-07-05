part of 'message_bloc.dart';

@immutable
sealed class MessageEvent {}

class GetConversationList extends MessageEvent {
  final bool isResetConservationDetail;

  GetConversationList({this.isResetConservationDetail = false});

  List<Object> get props => [isResetConservationDetail];
}

class GetConservationDetail extends MessageEvent {
  final String conversationId;
  final String recipientId;
  final bool isGetById;
  final int page;
  final bool isGetNewMessage;
  final bool showLoading;
  final bool isFetchNextPage;

  GetConservationDetail({
    this.conversationId = '',
    this.recipientId = '',
    this.page = 1,
    this.isGetNewMessage = false,
    this.isGetById = false,
    this.showLoading = false,
    this.isFetchNextPage = false,
  });

  List<Object> get props => [
        conversationId,
        recipientId,
        page,
        isGetById,
        showLoading,
        isFetchNextPage,
      ];
}

class SendMessage extends MessageEvent {
  final String content;
  final String recipient;
  final List<File> files;

  SendMessage({
    required this.content,
    required this.recipient,
    this.files = const [],
  });

  List<Object> get props => [content, recipient, files];
}

class DeleteMessage extends MessageEvent {
  final String content;
  final String recipient;
  final int idMessage;
  DeleteMessage({
    required this.content,
    required this.idMessage,
    required this.recipient,
  });
  List<Object> get props => [content, idMessage, recipient];
}

class DeleteConservation extends MessageEvent {
  final int conservationId;
  DeleteConservation({
    required this.conservationId,
  });
  List<Object> get props => [conservationId];
}

class GetPinMessage extends MessageEvent {
  final String recipientId;

  GetPinMessage({required this.recipientId});
}

class PinMessage extends MessageEvent {
  final String conservationId;
  final int idMessage;

  PinMessage({
    required this.idMessage,
    required this.conservationId,
  });

  List<Object> get props => [idMessage, conservationId];
}

class UnPinMessage extends MessageEvent {
  final int idMessage;
  UnPinMessage({required this.idMessage});
  List<Object> get props => [
        idMessage,
      ];
}

class GetPhoneBookStudent extends MessageEvent {}
