part of 'current_user_bloc.dart';

class CurrentUserState extends Equatable {
  const CurrentUserState({
    required this.user,
    this.background = SchoolBrand.uka,
  });

  final ProfileInfo user;
  final SchoolBrand background;

  CurrentUserState copyWith({
    ProfileInfo? user,
    SchoolBrand? background,
  }) {
    return CurrentUserState(
      user: user ?? this.user,
      background: background ?? this.background,
    );
  }

  @override
  List<Object> get props => [user, background];
}
