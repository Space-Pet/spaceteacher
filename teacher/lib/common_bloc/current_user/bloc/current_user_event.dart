part of '../current_user_bloc.dart';

abstract class CurrentUserEvent {}

class CurrentUserUpdated extends CurrentUserEvent {
  CurrentUserUpdated({required this.user});
  final LocalTeacher user;
}

class BackGroundUpdatedState extends CurrentUserEvent {
  BackGroundUpdatedState({required this.bg});
  final SchoolBrand bg;
}
