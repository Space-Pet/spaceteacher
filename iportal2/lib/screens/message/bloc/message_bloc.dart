import 'dart:io';

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
      : super(MessageState(
          conservationList: Conservation.fakeData(),
          conservationDetail: ConservationDetail.fakeData(),
        )) {
    on<GetConversationList>(_onGetConversationList);
    on<GetConservationDetail>(_onGetConservationDetail);
    on<SendMessage>(_onSendMessage);
    on<DeleteMessage>(_onDeleteMessage);
    on<DeleteConservation>(_onDeleteConservation);

    on<GetPinMessage>(_onGetPinMessage);
    on<PinMessage>(_onPinMessage);
    on<UnPinMessage>(_onUnPinMessage);

    on<GetPhoneBookStudent>(_onGetPhoneBookStudent);
  }

  _onGetConversationList(
    GetConversationList event,
    Emitter<MessageState> emit,
  ) async {
    try {
      if (!event.isResetConservationDetail) {
        emit(state.copyWith(
            messageStatus: MessageStatus.loadingConservationList));
      }

      final data = await appApiRepository.getListMessage(
        schoolId: currentUserBloc.state.activeChild.school_id,
        schoolBrand: currentUserBloc.state.activeChild.school_brand,
        classId: currentUserBloc.state.user.children[0].class_id.toString(),
        userId: currentUserBloc.state.user.user_id.toString(),
      );

      emit(state.copyWith(
        messageStatus: MessageStatus.successConservationList,
        conservationList: data,
      ));

      if (event.isResetConservationDetail) {
        emit(state.copyWith(
          currentPage: 1,
          hasMoreData: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(messageStatus: MessageStatus.errorConservationList));
    }
  }

  _onGetConservationDetail(
    GetConservationDetail event,
    Emitter<MessageState> emit,
  ) async {
    if (event.isFetchNextPage && !state.hasMoreData) {
      return;
    }

    if (event.showLoading) {
      emit(state.copyWith(
        conservationDetail: ConservationDetail.fakeData(),
        messageDetailStatus: MessageStatus.loadingConservationDetail,
        isFirstLoadChatRoom: false,
      ));
    }

    if (event.isFetchNextPage) {
      emit(state.copyWith(
          messageDetailStatus: MessageStatus.loadingLoadMoreMessages));
    }

    if (event.isGetNewMessage) {
      emit(state.copyWith(
          messageDetailStatus: MessageStatus.loadingGetNewMessage));
    }

    try {
      final data = await appApiRepository.getMessageDetail(
        conversationId: event.conversationId,
        recipientId: event.recipientId,
        isGetById: event.isGetById,
        schoolId: currentUserBloc.state.activeChild.school_id,
        schoolBrand: currentUserBloc.state.activeChild.school_brand,
        page: event.isFetchNextPage ? state.currentPage + 1 : state.currentPage,
      );

      if (event.isFetchNextPage) {
        emit(state.copyWith(
          conservationDetail: state.conservationDetail +
              data['data'].map<ConservationDetail>((e) {
                return ConservationDetail.fromJson(e);
              }).toList(),
          messageDetailStatus: MessageStatus.successLoadMoreMessages,
        ));
      } else {
        emit(
          state.copyWith(
            conservationDetail: data['data'].map<ConservationDetail>((e) {
              return ConservationDetail.fromJson(e);
            }).toList(),
            messageDetailStatus: MessageStatus.successGetNewMessage,
          ),
        );
      }

      emit(
        state.copyWith(
          currentPage: data['current_page'],
          hasMoreData: data['current_page'] < data['last_page'] ?? false,
          profileInfo: currentUserBloc.state.user,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          messageDetailStatus: MessageStatus.errorConservationDetail));
    }
  }

  _onSendMessage(
    SendMessage event,
    Emitter<MessageState> emit,
  ) async {
    try {
      emit(state.copyWith(
          messageDetailStatus: MessageStatus.loadingSendMessage));
      final data = await appApiRepository.postMessage(
        recipient: event.recipient,
        content: event.content,
        schoolId: currentUserBloc.state.activeChild.school_id,
        schoolBrand: currentUserBloc.state.activeChild.school_brand,
        classId: currentUserBloc.state.activeChild.class_id.toString(),
        files: event.files,
      );

      emit(state.copyWith(
        messageDetailStatus: MessageStatus.successSendMessage,
        conversationID: data,
      ));
    } catch (e) {
      emit(state.copyWith(messageDetailStatus: MessageStatus.errorSendMessage));
    }
  }

  _onDeleteConservation(
    DeleteConservation event,
    Emitter<MessageState> emit,
  ) async {
    try {
      emit(state.copyWith(
          messageStatus: MessageStatus.loadingDeleteConservation));
      await appApiRepository.deleteConservation(
        schoolId: currentUserBloc.state.activeChild.school_id,
        schoolBrand: currentUserBloc.state.activeChild.school_brand,
        conservationId: event.conservationId,
      );
      emit(state.copyWith(
          messageStatus: MessageStatus.successDeleteConservation));
    } catch (e) {
      emit(
          state.copyWith(messageStatus: MessageStatus.errorDeleteConservation));
    }
  }

  _onDeleteMessage(
    DeleteMessage event,
    Emitter<MessageState> emit,
  ) async {
    emit(state.copyWith(
        messageDetailStatus: MessageStatus.loadingDeleteMessage));
    final data = await appApiRepository.deleteMessage(
      content: event.content,
      schoolId: currentUserBloc.state.activeChild.school_id,
      schoolBrand: currentUserBloc.state.activeChild.school_brand,
      recipient: event.recipient,
      idMessage: event.idMessage,
    );

    if (data['code'] == null) {
      emit(state.copyWith(
          messageDetailStatus: MessageStatus.errorDeleteMessage));
      return;
    }

    if (data['code'] == 200) {
      emit(state.copyWith(
          messageDetailStatus: MessageStatus.successDeleteMessage));
    }
  }

  _onPinMessage(
    PinMessage event,
    Emitter<MessageState> emit,
  ) async {
    emit(state.copyWith(pinStatus: MessageStatus.loadingPinMessage));
    final data = await appApiRepository.postPinMessage(
      schoolId: currentUserBloc.state.activeChild.school_id,
      schoolBrand: currentUserBloc.state.activeChild.school_brand,
      idMessage: event.idMessage,
      conservationId: event.conservationId,
    );
    if (data?['code'] == 200) {
      emit(state.copyWith(pinStatus: MessageStatus.successPinMessage));
    } else {
      emit(state.copyWith(pinStatus: MessageStatus.errorPinMessage));
    }
  }

  _onUnPinMessage(
    UnPinMessage event,
    Emitter<MessageState> emit,
  ) async {
    emit(state.copyWith(pinStatus: MessageStatus.loadingUnpinMessage));
    final data = await appApiRepository.postDeletePinMessage(
      schoolId: currentUserBloc.state.activeChild.school_id,
      schoolBrand: currentUserBloc.state.activeChild.school_brand,
      idMessage: event.idMessage,
    );
    if (data?['code'] == 200) {
      emit(state.copyWith(pinStatus: MessageStatus.successUnpinMessage));
    } else {
      emit(state.copyWith(pinStatus: MessageStatus.errorUnpinMessage));
    }
  }

  _onGetPinMessage(
    GetPinMessage event,
    Emitter<MessageState> emit,
  ) async {
    emit(state.copyWith(pinStatus: MessageStatus.loadingGetPinMessage));

    final data = await appApiRepository.getMessagePin(
      recipientId: event.recipientId,
      schoolId: currentUserBloc.state.activeChild.school_id,
      schoolBrand: currentUserBloc.state.activeChild.school_brand,
    );

    if (data != null) {
      emit(state.copyWith(
        pinStatus: MessageStatus.successGetPinMessage,
        messagePin: data,
      ));
    } else {
      emit(state.copyWith(
          pinStatus: MessageStatus.errorGetPinMessage,
          messagePin: const ConservationDetail(
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

  void _onGetPhoneBookStudent(
      GetPhoneBookStudent event, Emitter<MessageState> emit) async {
    emit(state.copyWith(
        messageDetailStatus: MessageStatus.loadingGetPhoneBookStudent));
    final data = await appApiRepository.getPhoneBookStudent(
        classId: currentUserBloc.state.user.children[0].class_id);
    emit(state.copyWith(
      messageDetailStatus: MessageStatus.successGetPhoneBookStudent,
      phoneBookStudent: data,
    ));
  }
}
