part of 'notification_bloc.dart';

enum NotificationStatus { init, loading, success, failure }

enum ViewMode { all, unRead }

extension ViewModeX on ViewMode {
  int get value {
    switch (this) {
      case ViewMode.all:
        return -1;
      case ViewMode.unRead:
        return 0;
    }
  }
}

enum NotificationOrderBy { desc, asc }

extension NotificationOrderByX on NotificationOrderBy {
  String get value {
    switch (this) {
      case NotificationOrderBy.desc:
        return 'desc';
      case NotificationOrderBy.asc:
        return 'asc';
    }
  }
}

class NotificationState extends Equatable {
  const NotificationState({
    required this.notificationData,
    this.viewMode = ViewMode.all,
    this.status = NotificationStatus.init,
  });

  final NotificationData notificationData;
  final ViewMode viewMode;
  final NotificationStatus status;

  @override
  List<Object?> get props => [notificationData, viewMode, status];

  NotificationState copyWith({
    NotificationData? notificationData,
    NotificationStatus? status,
    ViewMode? viewMode,
  }) {
    return NotificationState(
      notificationData: notificationData ?? this.notificationData,
      status: status ?? this.status,
      viewMode: viewMode ?? this.viewMode,
    );
  }
}
