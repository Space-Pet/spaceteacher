part 'activities_badge_repository.impl.dart';

abstract class ActivitiesBadgeRepository {
  Future<int?> getBadgeCount();
}
