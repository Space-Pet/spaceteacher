part of 'notification_service_bloc.dart';

@immutable
abstract class NotificationServiceState {
  final int unreadBadgeCount;

  NotificationServiceState(this.unreadBadgeCount);
}

class NotificationServiceInitial extends NotificationServiceState {
  NotificationServiceInitial({
    int unreadBadgeCount = 0,
  }) : super(unreadBadgeCount);
}
