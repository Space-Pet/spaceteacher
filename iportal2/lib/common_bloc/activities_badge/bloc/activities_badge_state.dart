part of 'activities_badge_bloc.dart';

abstract class ActivitiesBadgeState {
  final int unreadBadgeCount;

  ActivitiesBadgeState({required this.unreadBadgeCount});
}

class ActivitiesBadgeInitial extends ActivitiesBadgeState {
  ActivitiesBadgeInitial({
    int unreadBadgeCount = 0,
  }) : super(unreadBadgeCount: unreadBadgeCount);
}
