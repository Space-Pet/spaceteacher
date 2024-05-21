part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetListNotification extends NotificationEvent {
  final String orderBy;
  final int schoolId;
  final String schoolBrand;

  const GetListNotification({
    required this.orderBy,
    required this.schoolId,
    required this.schoolBrand,
  });

  @override
  List<Object> get props => [orderBy, schoolId, schoolBrand];
}

class GetDetailNotification extends NotificationEvent {
  final int notificationId;
  final int schoolId;
  final String schoolBrand;

  const GetDetailNotification({
    required this.notificationId,
    required this.schoolId,
    required this.schoolBrand,
  });

  @override
  List<Object> get props => [notificationId, schoolId, schoolBrand];
}
