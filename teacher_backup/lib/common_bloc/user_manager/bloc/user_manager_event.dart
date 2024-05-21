part of 'user_manager_bloc.dart';

abstract class UserManagerEvent {
  const UserManagerEvent();
}

class UserManagerUpdated extends UserManagerEvent {
  const UserManagerUpdated({required this.userInfo});
  final UserInfo userInfo;
}

class UserManagerGetUser extends UserManagerEvent {
  const UserManagerGetUser();
}
