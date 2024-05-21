part of 'current_user_bloc.dart';

class CurrentUserState extends Equatable {
  const CurrentUserState({
    required this.user,
    required this.activeChild,
    this.background = SchoolBrand.uka,
  });

  final ProfileInfo user;
  final SchoolBrand background;
  final Children activeChild;

  CurrentUserState copyWith({
    ProfileInfo? user,
    Children? activeChild,
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
