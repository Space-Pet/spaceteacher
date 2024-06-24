part of 'current_user_bloc.dart';

abstract class CurrentUserEvent {
  // Cache user data
}

class CurrentUserUpdated extends CurrentUserEvent {
  CurrentUserUpdated({required this.user});
  final LocalIPortalProfile user;
}

class CurrentUserChangeActiveChild extends CurrentUserEvent {
  CurrentUserChangeActiveChild(this.child);
  final LocalChildren child;
}

class BackGroundUpdatedState extends CurrentUserEvent {
  BackGroundUpdatedState({required this.bg});
  final SchoolBrand bg;
}

class CurrentUserNotify extends CurrentUserEvent {
  CurrentUserNotify(this.pushNotify);

  final int pushNotify;
}
