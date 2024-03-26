part of 'splash_bloc.dart';

enum SplashStatus { initial, hasNotLogin, success, failure }

class SplashState extends Equatable {
  final SplashStatus status;
  final String? errorMessage;

  const SplashState({
    this.status = SplashStatus.initial,
    this.errorMessage,
  });

  SplashState copyWith({
    SplashStatus? status,
    String? errorMessage,
  }) {
    return SplashState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [status, errorMessage];
}