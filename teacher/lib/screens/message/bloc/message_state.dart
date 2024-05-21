part of 'message_bloc.dart';

enum MessageStatus { init, loading, success, error }

class MessageState {
  final List<Message> messages;
  final MessageStatus messageStatus;
  final List<PhoneBookStudent> phoneBookStudent;
  const MessageState(
      {this.messages = const [],
      this.messageStatus = MessageStatus.init,
      this.phoneBookStudent = const []});

  MessageState copyWith({
    List<Message>? messages,
    MessageStatus? messageStatus,
    List<PhoneBookStudent>? phoneBookStudent,
  }) {
    return MessageState(
        phoneBookStudent: phoneBookStudent ?? this.phoneBookStudent,
        messageStatus: messageStatus ?? this.messageStatus,
        messages: messages ?? this.messages);
  }

  List<Object?> get props => [messageStatus, messages, phoneBookStudent];
}
