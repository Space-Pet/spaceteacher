import 'dart:io';

import 'package:core/core.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/screens/notifications/bloc/notification_bloc.dart';
import 'package:repository/repository.dart';

part 'noti_detail_event.dart';
part 'noti_detail_state.dart';

class NotiDetailBloc extends Bloc<NotiDetailEvent, NotiDetailState> {
  NotiDetailBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
  }) : super(NotiDetailState(notiDetail: SentNotiDetail.empty())) {
    on<NotificationFetchDetail>(_onFetchNotiDetail);
    on<NotificationDelete>(_onDeleteNoti);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onFetchNotiDetail(
      NotificationFetchDetail event, Emitter<NotiDetailState> emit) async {
    emit(state.copyWith(status: NotificationStatus.loading));

    final user = currentUserBloc.state.user;
    final headers = {
      'School-Id': user.school_id,
      'School-Brand': user.school_brand,
    };

    final notiDetailData = await appFetchApiRepo.getNotiDetailTeacher(
      headers: headers,
      id: event.id,
    );

    final imageFiles = notiDetailData.notification.attachments
        .where((element) => element.fileType.contains('image'))
        .toList();

    final otherFiles = notiDetailData.notification.attachments
        .where((element) => !element.fileType.contains('image'))
        .toList();

    emit(state.copyWith(
      notiDetail: notiDetailData,
      imageFiles: imageFiles,
      otherFiles: otherFiles,
      status: NotificationStatus.success,
    ));
  }

  _onDeleteNoti(NotificationDelete event, Emitter<NotiDetailState> emit) async {
    emit(state.copyWith(status: NotificationStatus.loading));

    final response = await appFetchApiRepo.deleteNoti(id: event.id);

    if (response['status'] == 'success' && response['code'] == 200) {
      emit(state.copyWith(status: NotificationStatus.deleteSuccess));
    } else if (response is Error) {
      emit(state.copyWith(status: NotificationStatus.deleteFailure));
    }
  }
}
