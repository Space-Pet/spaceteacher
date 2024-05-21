import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/repository/user_repository/user_repositories.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.userRepository})
      : super(HomeState(userInfo: UserInfo())) {
    on<HomeInit>(_onHomeInit);
  }
  final UserRepository userRepository;
  Future<void> _onHomeInit(HomeInit event, Emitter<HomeState> emit) async {
    try {
      final userInfo = await userRepository.getUserInfo();
      emit(state.copyWith(userInfo: userInfo));
    } catch (e) {
      rethrow;
    }
  }
}
