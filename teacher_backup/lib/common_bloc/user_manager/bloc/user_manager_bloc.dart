import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/repository/user_repository/user_repositories.dart';
part 'user_manager_state.dart';
part 'user_manager_event.dart';

class UserManagerBloc extends Bloc<UserManagerEvent, UserManagerState> {
  UserManagerBloc({required this.userRepository})
      : super(
          UserManagerState(
            userInfo: UserInfo(),
          ),
        ) {
    on<UserManagerUpdated>(_onUpdateUser);
    on<UserManagerGetUser>(_getUserInfo);
  }

  final UserRepository userRepository;

  Future<dynamic> _onUpdateUser(
    UserManagerUpdated event,
    Emitter<UserManagerState> emit,
  ) async {
    try {
      emit(state.copyWith(
        userInfo: event.userInfo,
      ));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _getUserInfo(
      UserManagerGetUser event, Emitter<UserManagerState> emit) async {
    try {
      final userInfo = await userRepository.getUserInfo();
      emit(state.copyWith(userInfo: userInfo));
    } catch (e) {
      rethrow;
    }
  }
}
