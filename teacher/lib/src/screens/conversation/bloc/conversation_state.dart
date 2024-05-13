part of 'conversation_bloc.dart';

enum ConversationStatus { initial, loading, loaded, error }

class ConversationState extends Equatable {
  final ConversationModel? conversation;
  final ConversationStatus status;
  final String? error;

  const ConversationState({
    this.conversation,
    this.status = ConversationStatus.initial,
    this.error,
  });

  ConversationState copyWith({
    ConversationModel? conversation,
    ConversationStatus? status,
    String? error,
  }) {
    return ConversationState(
      conversation: conversation ?? this.conversation,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [conversation, status, error];
}
