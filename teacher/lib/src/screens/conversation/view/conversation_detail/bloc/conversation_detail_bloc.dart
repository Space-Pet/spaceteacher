import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/model/message_detail_model.dart';

part 'conversation_detail_event.dart';
part 'conversation_detail_state.dart';

class ConversationDetailBloc
    extends Bloc<ConversationDetailEvent, ConversationDetailState> {
  ConversationDetailBloc()
      : super(const ConversationDetailState(
            status: ConversationDetailStatus.initial)) {
    on<ConversationDetailEventSendMessage>(_onSendMessage);
  }

  Future<void> _onSendMessage(ConversationDetailEventSendMessage event,
      Emitter<ConversationDetailState> emit) async {}
}
