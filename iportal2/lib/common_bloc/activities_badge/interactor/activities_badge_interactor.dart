import 'package:core/common/utils/log_utils.dart';

import '../repository/activities_badge_repository.dart';

part 'activities_badge_interactor.impl.dart';

abstract class ActivitiesBadgeInteractor {
  Future<int?> getBadgeCount();
}
