part of 'user_manager_bloc.dart';

class UserManagerState extends Equatable {
  const UserManagerState({required this.userInfo});

  final UserInfo userInfo;

  UserManagerState copyWith({
    UserInfo? userInfo,
  }) {
    return UserManagerState(
      userInfo: userInfo ?? this.userInfo,
    );
  }

  @override
  List<Object> get props => [userInfo];
}
