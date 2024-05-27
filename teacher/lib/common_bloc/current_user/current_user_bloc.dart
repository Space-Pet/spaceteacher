import 'package:core/core.dart';
import 'package:repository/repository.dart';

part 'bloc/current_user_event.dart';
part 'bloc/current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  CurrentUserBloc({required this.userRepository})
      : super(CurrentUserState(user: LocalTeacher.empty())) {
    on<CurrentUserUpdated>(_onUpdateUser);
    on<BackGroundUpdatedState>(updateBg);
  }

  final UserRepository userRepository;

  Future<dynamic> _onUpdateUser(
    CurrentUserUpdated event,
    Emitter<CurrentUserState> emit,
  ) async {
    emit(state.copyWith(user: event.user));
  }

  void updateBg(
    BackGroundUpdatedState event,
    Emitter<CurrentUserState> emit,
  ) async {
    emit(state.copyWith(
      background: event.bg,
    ));
  }
}
