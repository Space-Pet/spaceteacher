part of 'notification_bloc.dart';

enum NotificationStatus { initial, loading, loaded, error }

class NotificationState extends Equatable {
  final List<NotificationDetailModel>? listNotification;
  final NotificationDetailModel? detailNotification;
  final NotificationStatus? status;
  final String? errorMessage;

  const NotificationState({
    this.listNotification,
    this.detailNotification,
    this.status,
    this.errorMessage,
  });

  NotificationState copyWith({
    List<NotificationDetailModel>? listNotification,
    NotificationDetailModel? detailNotification,
    NotificationStatus? status,
    String? errorMessage,
  }) {
    return NotificationState(
      listNotification: listNotification ?? this.listNotification,
      detailNotification: detailNotification ?? this.detailNotification,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [listNotification, detailNotification, status, errorMessage];
}
