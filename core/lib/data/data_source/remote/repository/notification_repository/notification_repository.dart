import 'dart:async';


import '../../../../models/notification_model.dart';

// part 'notification_repository_impl.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getNewNotificationiportal(
    int offset,
    int limit,
  );

  Future<List<NotificationModel>> getNewNotificationPartner(
    int offset,
    int limit,
  );

  Future<List<NotificationModel>> getWorkingNotification(
    int offset,
    int limit,
  );

  // allow id is null as mark all as read
  Future<bool> markReadNotificaiton(String? id, String userId);

  // allow id is null as mark all as read
  Future<bool> markReadNewsNotificaiton(String? id, String userId);

  Future<int?> getNumOfUnreadNotifications();

  Future<int?> getNumOfUnreadNotificationsPartner();

  Future<NotificationModel?> getNotificationDetail(
    String id,
  );
}
