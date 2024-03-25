import 'package:core/data/data_source/remote/repository/notification_repository/notification_repository.dart';

part 'notification_service_repository.impl.dart';

abstract class NotificationServiceRepository {
  Future<int?> getBadgeCount();
}
