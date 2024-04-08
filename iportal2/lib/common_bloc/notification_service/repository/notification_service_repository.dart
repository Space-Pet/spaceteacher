part 'notification_service_repository.impl.dart';

abstract class NotificationServiceRepository {
  Future<int?> getBadgeCount();
}
