part of 'current_user_bloc.dart';

class CurrentUserState extends Equatable {
  const CurrentUserState({
    required this.user,
    required this.activeChild,
    this.background = SchoolBrand.uka,
  });

  final LocalIPortalProfile user;
  final SchoolBrand background;
  final LocalChildren activeChild;

  CurrentUserState copyWith({
    LocalIPortalProfile? user,
    LocalChildren? activeChild,
    SchoolBrand? background,
  }) {
    return CurrentUserState(
      user: user ?? this.user,
      activeChild: activeChild ?? this.activeChild,
      background: background ?? this.background,
    );
  }

  @override
  List<Object> get props => [user, background, activeChild];
}
