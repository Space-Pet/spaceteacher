part of 'noti_detail_bloc.dart';

sealed class NotiDetailEvent {}

class NotificationFetchDetail extends NotiDetailEvent {
  NotificationFetchDetail({
    required this.id,
  });

  final int id;
}
