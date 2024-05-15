part of 'conversation_detail_bloc.dart';

enum ConversationDetailStatus { initial, loading, loaded, error }

class ConversationDetailState extends Equatable {
  const ConversationDetailState({
    this.status = ConversationDetailStatus.initial,
    this.messages,
    this.page = 1,
    this.hasMore = true,
    this.error = '',
  });

  final ConversationDetailStatus? status;
  final MessageDetailModel? messages;
  final int? page;
  final bool? hasMore;
  final String? error;

  ConversationDetailState copyWith({
    ConversationDetailStatus? status,
    MessageDetailModel? messages,
    int? page,
    bool? hasMore,
    String? error,
  }) {
    return ConversationDetailState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, messages, page, hasMore, error];
}
