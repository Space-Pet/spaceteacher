import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/model/conversation_model.dart';
import 'package:teacher/repository/conversation_repository/conversation_repositories.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc({required this.conversationRepository})
      : super(const ConversationState(status: ConversationStatus.initial)) {
    on<GetConversation>(_getConversation);
  }
  final ConversationRepository conversationRepository;
  Future<void> _getConversation(
      GetConversation event, Emitter<ConversationState> emit) async {
    try {
      emit(state.copyWith(status: ConversationStatus.loading));
      final res = await conversationRepository.getConversation(
          userId: event.userId, classId: event.classId);
      emit(
          state.copyWith(conversation: res, status: ConversationStatus.loaded));
    } catch (e) {
      Log.e(e.toString());
      emit(state.copyWith(
          status: ConversationStatus.error, error: e.toString()));
    }
  }
}
