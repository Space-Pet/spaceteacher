import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  CurrentUserBloc({required this.userRepository})
      : super(
          CurrentUserState(
            user: userRepository.notSignedIn(),
          ),
        ) {
    on<CurrentUserUpdated>(_onUpdateUser);
  }

  final UserRepository userRepository;

  Future<dynamic> _onUpdateUser(
    CurrentUserUpdated event,
    Emitter<CurrentUserState> emit,
  ) async {
    emit(state.copyWith(
      user: event.user,
    ));
  }
}
