part of '../current_user_bloc.dart';

class CurrentUserState extends Equatable {
  const CurrentUserState({
    required this.user,
    this.background = SchoolBrand.uka,
    this.pushNotify = 1,
  });

  final LocalTeacher user;
  final SchoolBrand background;
  final int pushNotify;

  CurrentUserState copyWith({
    LocalTeacher? user,
    SchoolBrand? background,
    int? pushNotify,
  }) {
    return CurrentUserState(
      user: user ?? this.user,
      background: background ?? this.background,
      pushNotify: pushNotify ?? this.pushNotify,
    );
  }

  @override
  List<Object> get props => [user, background, pushNotify];
}
