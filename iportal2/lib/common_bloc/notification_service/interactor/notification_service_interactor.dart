import 'package:core/common/utils/log_utils.dart';

import '../repository/notification_service_repository.dart';

part 'notification_service_interactor.impl.dart';

abstract class NotificationServiceInteractor {
  Future<int?> getBadgeCount();
}
