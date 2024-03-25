part of 'notification_service_bloc.dart';

@immutable
abstract class NotificationServiceEvent {}

class GetBadgeCountEvent extends NotificationServiceEvent {}
