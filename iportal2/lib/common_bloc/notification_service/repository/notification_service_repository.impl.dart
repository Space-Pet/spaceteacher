part of 'notification_service_repository.dart';

class NotificationServiceRepositoryImpl extends NotificationServiceRepository {
  final NotificationRepository _notiRepo;

  NotificationServiceRepositoryImpl(this._notiRepo);
  @override
  Future<int?> getBadgeCount() async {
    return _notiRepo.getNumOfUnreadNotifications();
  }
}
