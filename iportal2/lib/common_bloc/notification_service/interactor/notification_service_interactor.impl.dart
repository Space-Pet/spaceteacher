part of 'notification_service_interactor.dart';

class NotificationServiceInteractorImpl extends NotificationServiceInteractor {
  final NotificationServiceRepository _repository;

  NotificationServiceInteractorImpl(this._repository);

  @override
  Future<int?> getBadgeCount() {
    return _repository.getBadgeCount().then(Future<int?>.value).catchError(
          (error, stackTrace) => LogUtils.eCatch<int>(
            'getBadgeCount error',
            error,
            stackTrace,
          ),
        );
  }
}
