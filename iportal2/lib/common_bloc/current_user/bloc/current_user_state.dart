part of 'current_user_bloc.dart';

class CurrentUserState extends Equatable {
  const CurrentUserState({
    required this.user,
    required this.activeChild,
    this.background = SchoolBrand.uka,
    this.pushNotify = 1,
  });

  final LocalIPortalProfile user;
  final SchoolBrand background;
  final LocalChildren activeChild;
  final int pushNotify;

  CurrentUserState copyWith({
    LocalIPortalProfile? user,
    LocalChildren? activeChild,
    SchoolBrand? background,
    int? pushNotify,
  }) {
    return CurrentUserState(
      user: user ?? this.user,
      activeChild: activeChild ?? this.activeChild,
      background: background ?? this.background,
      pushNotify: pushNotify ?? this.pushNotify,
    );
  }

  @override
  List<Object> get props => [
        user,
        background,
        activeChild,
        pushNotify,
      ];
}
