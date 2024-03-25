part of 'activities_badge_interactor.dart';

class ActivitiesBadgeInteractorImpl extends ActivitiesBadgeInteractor {
  final ActivitiesBadgeRepository _repository;

  ActivitiesBadgeInteractorImpl(this._repository);

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
