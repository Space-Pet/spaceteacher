// ignore_for_file: unused_local_variable

import 'package:core/core.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final AppFetchApiRepository appApiRepository;
  final CurrentUserBloc currentUserBloc;
  MessageBloc({required this.appApiRepository, required this.currentUserBloc})
      : super(const MessageState()) {
    on<GetListMessage>(_onGetListMessage);
    on<GetPhoneBookStudent>(_onGetPhoneBookStudent);
    on<GetMessageDetail>(_onGetMessageDetail);
    on<PostMessage>(_onPostMessage);
    on<GetMessageDetailRestart>(_onGetMessageDetailRestart);
    on<DeleteMessageDetail>(_onDeleteMessageDetail);
    on<DeleteMessage>(_onDeleteMessage);
    on<GetListMessageResert>(_onGetMessageResart);
    on<PinMessage>(_onPinMessage);
    on<DeletePinMessage>(_onDeletePinMessage);
    on<GetPinMessage>(_onGetPinMessage);
  }

  _onPinMessage(
    PinMessage event,
    Emitter<MessageState> emit,
  ) async {
    emit(state.copyWith(messageStatus: MessageStatus.loadingPostPinMessage));
    final data = await appApiRepository.postPinMessage(
      schoolId: currentUserBloc.state.activeChild.school_id,
      schoolBrand: currentUserBloc.state.activeChild.school_brand,
      idMessage: event.idMessage,
    );
    if (data?['code'] == 200) {
      emit(state.copyWith(messageStatus: MessageStatus.successPostPinMessage));
    } else {
      emit(state.copyWith(messageStatus: MessageStatus.error));
    }
  }

  _onDeletePinMessage(
    DeletePinMessage event,
    Emitter<MessageState> emit,
  ) async {
    emit(state.copyWith(messageStatus: MessageStatus.loadingDeletePinMessage));
    final data = await appApiRepository.postDeletePinMessage(
      schoolId: currentUserBloc.state.activeChild.school_id,
      schoolBrand: currentUserBloc.state.activeChild.school_brand,
      idMessage: event.idMessage,
    );
    if (data?['code'] == 200) {
      emit(
          state.copyWith(messageStatus: MessageStatus.successDeletePinMessage));
    } else {
      emit(state.copyWith(messageStatus: MessageStatus.error));
    }
  }

  _onGetPinMessage(
    GetPinMessage event,
    Emitter<MessageState> emit,
  ) async {
    emit(state.copyWith(messageStatus: MessageStatus.loadingGetPinMessage));
    final data = await appApiRepository.getMessagePin(
      schoolId: currentUserBloc.state.activeChild.school_id,
      schoolBrand: currentUserBloc.state.activeChild.school_brand,
    );
    if (data != null) {
      emit(state.copyWith(
          messageStatus: MessageStatus.successGetPinMessage, messagePin: data));
    } else {
      emit(state.copyWith(
          messageStatus: MessageStatus.successGetPinMessage,
          messagePin: const MessageDetail(
              avatarUrl: '',
              content: '',
              fullName: '',
              id: 0,
              recipient: 0,
              schoolId: 0,
              userId: 0,
              userType: 0)));
    }
  }

  _onDeleteMessage(
    DeleteMessage event,
    Emitter<MessageState> emit,
  ) async {
    emit(state.copyWith(messageStatus: MessageStatus.loadingDelete));
    await appApiRepository.deleteMessage(
      schoolId: currentUserBloc.state.activeChild.school_id,
      schoolBrand: currentUserBloc.state.activeChild.school_brand,
      idMessage: event.idMessage,
    );
    emit(state.copyWith(messageStatus: MessageStatus.successDelete));
  }

  _onDeleteMessageDetail(
    DeleteMessageDetail event,
    Emitter<MessageState> emit,
  ) async {
    emit(state.copyWith(messageStatus: MessageStatus.loadingDelete));
    await appApiRepository.deleteMessageDetail(
      content: event.content,
      schoolId: currentUserBloc.state.activeChild.school_id,
      schoolBrand: currentUserBloc.state.activeChild.school_brand,
      recipient: event.recipient,
      idMessage: event.idMessage,
    );
    emit(state.copyWith(messageStatus: MessageStatus.successDelete));
  }

  _onPostMessage(
    PostMessage event,
    Emitter<MessageState> emit,
  ) async {
    emit(state.copyWith(messageStatus: MessageStatus.loadingMessage));
    final data = await appApiRepository.postMessage(
      recipient: event.recipient,
      content: event.content,
      schoolId: currentUserBloc.state.activeChild.school_id,
      schoolBrand: currentUserBloc.state.activeChild.school_brand,
      classId: currentUserBloc.state.user.children[0].class_id.toString(),
    );
    emit(state.copyWith(
        messageStatus: MessageStatus.successMessage, conversationID: data));
  }

  _onGetMessageDetail(
    GetMessageDetail event,
    Emitter<MessageState> emit,
  ) async {
    emit(state.copyWith(messageStatus: MessageStatus.loading));
    final data = await appApiRepository.getMessageDetail(
      conversationId: event.conversationId,
      schoolId: currentUserBloc.state.activeChild.school_id,
      schoolBrand: currentUserBloc.state.activeChild.school_brand,
      page: event.page,
    );
    emit(
      state.copyWith(
          messageStatus: MessageStatus.success,
          messageDetail: data['data'].map<MessageDetail>((e) {
            return MessageDetail.fromJson(e);
          }).toList(),
          currentPage: data['current_page'],
          hasMoreData: data['current_page'] < data['last_page'] ?? false,
          profileInfo: currentUserBloc.state.user),
    );
  }

  _onGetMessageDetailRestart(
    GetMessageDetailRestart event,
    Emitter<MessageState> emit,
  ) async {
    emit(state.copyWith(messageStatus: MessageStatus.loadingRestart));
    final data = await appApiRepository.getMessageDetail(
      conversationId: event.conversationId,
      schoolId: currentUserBloc.state.activeChild.school_id,
      schoolBrand: currentUserBloc.state.activeChild.school_brand,
      page: event.page,
    );
    emit(
      state.copyWith(
          messageStatus: MessageStatus.successRestart,
          messageDetail: data['data'].map<MessageDetail>((e) {
            return MessageDetail.fromJson(e);
          }).toList(),
          currentPage: data['current_page'],
          hasMoreData: data['current_page'] < data['last_page'] ?? false,
          profileInfo: currentUserBloc.state.user),
    );
  }

  _onGetMessageResart(
    GetListMessageResert event,
    Emitter<MessageState> emit,
  ) async {
    try {
      emit(state.copyWith(messageStatus: MessageStatus.loadingRestart));
      final data = await appApiRepository.getListMessage(
        schoolId: currentUserBloc.state.activeChild.school_id,
        schoolBrand: currentUserBloc.state.activeChild.school_brand,
        classId: currentUserBloc.state.user.children[0].class_id.toString(),
        userId: currentUserBloc.state.user.user_id.toString(),
      );

      emit(state.copyWith(
          messageStatus: MessageStatus.successRestart, messages: data));
    } catch (e) {
      emit(state.copyWith(messageStatus: MessageStatus.error));
    }
  }

  _onGetListMessage(
    GetListMessage event,
    Emitter<MessageState> emit,
  ) async {
    try {
      emit(state.copyWith(messageStatus: MessageStatus.loading));
      final data = await appApiRepository.getListMessage(
        schoolId: currentUserBloc.state.activeChild.school_id,
        schoolBrand: currentUserBloc.state.activeChild.school_brand,
        classId: currentUserBloc.state.user.children[0].class_id.toString(),
        userId: currentUserBloc.state.user.user_id.toString(),
      );
      // final List<Message> combinedData = [...state.messages, ...data];
      emit(state.copyWith(
          messageStatus: MessageStatus.success,
          // messages: combinedData,
          messages: data));
    } catch (e) {
      emit(state.copyWith(messageStatus: MessageStatus.error));
    }
  }

  void _onGetPhoneBookStudent(
      GetPhoneBookStudent event, Emitter<MessageState> emit) async {
    emit(state.copyWith(messageStatus: MessageStatus.loading));
    final data = await appApiRepository.getPhoneBookStudent(
        classId: currentUserBloc.state.user.children[0].class_id);
    emit(state.copyWith(
        messageStatus: MessageStatus.success, phoneBookStudent: data));
  }
}
