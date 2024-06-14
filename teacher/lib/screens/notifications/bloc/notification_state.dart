part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    required this.notificationData,
    required this.sentNoti,
    this.viewMode = ViewMode.all,
    this.status = NotificationStatus.init,
  });

  final NotificationData notificationData;
  final NotificationData sentNoti;
  final ViewMode viewMode;
  final NotificationStatus status;

  @override
  List<Object?> get props => [notificationData, sentNoti, viewMode, status];

  NotificationState copyWith({
    NotificationData? notificationData,
    NotificationData? sentNoti,
    NotificationStatus? status,
    ViewMode? viewMode,
  }) {
    return NotificationState(
      notificationData: notificationData ?? this.notificationData,
      sentNoti: sentNoti ?? this.sentNoti,
      status: status ?? this.status,
      viewMode: viewMode ?? this.viewMode,
    );
  }
}

enum NotificationStatus {
  init,
  loading,
  success,
  failure,
  loadingSent,
  successSent,
  failureSent
}

enum ViewMode { all, unRead }

enum FilterType {
  read,
  unRead,
}

extension FilterTypeX on FilterType {
  String text() {
    switch (this) {
      case FilterType.read:
        return "Đã đọc";
      case FilterType.unRead:
        return "Chưa đọc";
      default:
        return "Chưa đọc";
    }
  }
}

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

enum SentNotiStatus { draft, active }

extension SentNotiStatusX on SentNotiStatus {
  String get value {
    switch (this) {
      case SentNotiStatus.draft:
        return 'draft';
      case SentNotiStatus.active:
        return 'active';
    }
  }
}
