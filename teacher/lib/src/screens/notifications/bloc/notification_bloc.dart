import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import 'package:teacher/model/notification_detail_model.dart';
import 'package:teacher/repository/notification_repository/notification_repositories.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({required this.notificationRepository})
      : super(const NotificationState()) {
    on<GetListNotification>(_getListNoti);
    on<GetDetailNotification>(_getDetailNoti);
  }
  final NotificationRepository notificationRepository;

  Future<List<NotificationDetailModel>> _getListNoti(
      GetListNotification event, Emitter<NotificationState> emit) async {
    try {
      emit(state.copyWith(status: NotificationStatus.loading));
      final res = await notificationRepository.getListNotification(
        orderBy: event.orderBy,
        schoolId: event.schoolId,
        schoolBrand: event.schoolBrand,
      );

      emit(state.copyWith(
          listNotification: res.listNotification ?? <NotificationDetailModel>[],
          status: NotificationStatus.loaded));
    } catch (e) {
      Log.e('$e',
          name:
              "Get List Notification Error NotificationBloc -> _getListNoti()");
      emit(
        state.copyWith(
          status: NotificationStatus.error,
          errorMessage: '$e',
          listNotification: <NotificationDetailModel>[],
        ),
      );
    }
    return <NotificationDetailModel>[];
  }

  Future<NotificationDetailModel> _getDetailNoti(
      GetDetailNotification event, Emitter<NotificationState> emit) async {
    try {
      final res = await notificationRepository.getDetailNotification(
        notificationId: event.notificationId,
        schoolId: event.schoolId,
        schoolBrand: event.schoolBrand,
      );

      emit(state.copyWith(
          detailNotification: res, status: NotificationStatus.loaded));
    } catch (e) {
      Log.e('$e',
          name:
              "Get Detail Notification Error NotificationBloc -> _getDetailNoti()");
      emit(
        state.copyWith(
          status: NotificationStatus.error,
          errorMessage: '$e',
          detailNotification: NotificationDetailModel(),
        ),
      );
    }

    return NotificationDetailModel();
  }
}
