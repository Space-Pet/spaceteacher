part of 'current_user_bloc.dart';

abstract class CurrentUserEvent {}

class CurrentUserUpdated extends CurrentUserEvent {
  CurrentUserUpdated({required this.user});
  final ProfileInfo user;
}
