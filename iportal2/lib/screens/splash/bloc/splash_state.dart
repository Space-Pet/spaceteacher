// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'splash_cubit.dart';

enum SplashStatus { init, firstLogin, logined, unLogined }

extension SplashStatusX on SplashStatus {
  bool get isLogined => this == SplashStatus.logined;
  bool get isUnLogined => this == SplashStatus.unLogined;
}

class SplashState extends Equatable {
  const SplashState({this.status = SplashStatus.init});
  final SplashStatus status;
  @override
  List<Object> get props => [status];

  SplashState copyWith({
    SplashStatus? status,
  }) {
    return SplashState(
      status: status ?? this.status,
    );
  }
}

class SplashStateCleanToken extends Equatable{

  const SplashStateCleanToken();
  @override
  List<Object> get props => [];
}
