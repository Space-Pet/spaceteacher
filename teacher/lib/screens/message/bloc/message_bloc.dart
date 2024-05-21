import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:teacher/common_bloc/current_user/bloc/current_user_bloc.dart';
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
  }
  _onGetListMessage(GetListMessage event, Emitter<MessageState> emit) async {
    try {
      emit(state.copyWith(messageStatus: MessageStatus.loading));
      final data = await appApiRepository.getListMessage(
          page: event.page,
          schoolId: currentUserBloc.state.user.school_id,
          schoolBrand: currentUserBloc.state.user.school_brand);
      final List<Message> combinedData = [...state.messages, ...data];
      emit(state.copyWith(
          messageStatus: MessageStatus.success, messages: combinedData));
    } catch (e) {
      emit(state.copyWith(messageStatus: MessageStatus.error));
    }
  }

  void _onGetPhoneBookStudent(
      GetPhoneBookStudent event, Emitter<MessageState> emit) async {
    emit(state.copyWith(messageStatus: MessageStatus.loading));
    final data = await appApiRepository.getPhoneBookStudent(
        classId: currentUserBloc.state.user.children?.class_id ?? 0,);
    emit(state.copyWith(
        messageStatus: MessageStatus.success, phoneBookStudent: data));
  }
}
