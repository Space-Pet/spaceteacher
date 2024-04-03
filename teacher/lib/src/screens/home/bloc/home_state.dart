part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({required this.userInfo});

  final UserInfo userInfo;

  HomeState copyWith({
    UserInfo? userInfo,
  }) {
    return HomeState(
      userInfo: userInfo ?? this.userInfo,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userInfo];
}
