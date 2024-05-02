part of 'message_bloc.dart';

@immutable
sealed class MessageEvent {}

class GetListMessage extends MessageEvent {
  final int page;
  GetListMessage({required this.page});
  List<Object> get props => [page];
}

class GetPhoneBookStudent extends MessageEvent {}
