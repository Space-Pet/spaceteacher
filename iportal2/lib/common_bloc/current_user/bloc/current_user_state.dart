part of 'current_user_bloc.dart';

class CurrentUserState extends Equatable {
  const CurrentUserState({required this.user});

  final ProfileInfo user;

  CurrentUserState copyWith({
    ProfileInfo? user,
  }) {
    return CurrentUserState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [user];
}
