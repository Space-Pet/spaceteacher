part of 'notification_bloc.dart';

sealed class NotificationEvent {}

class NotificationFetchData extends NotificationEvent {
  NotificationFetchData({
    this.viewed = -1,
    this.orderBy = NotificationOrderBy.desc,
  });

  final int viewed;
  final NotificationOrderBy orderBy;
}

class NotificationFetchSentNoti extends NotificationEvent {
  NotificationFetchSentNoti({
    this.status = SentNotiStatus.active,
    this.orderBy = NotificationOrderBy.desc,
  });

  final SentNotiStatus status;
  final NotificationOrderBy orderBy;
}

class NotificationChageViewMode extends NotificationEvent {
  NotificationChageViewMode({
    this.viewed = ViewMode.all,
  });

  final ViewMode viewed;
}
