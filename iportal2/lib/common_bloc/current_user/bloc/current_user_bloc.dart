import 'package:core/core.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  CurrentUserBloc({required this.userRepository})
      : super(
          CurrentUserState(
            activeChild: Children.empty(),
            user: userRepository.notSignedIn(),
          ),
        ) {
    on<CurrentUserUpdated>(_onUpdateUser);
    on<BackGroundUpdatedState>(updateBg);
  }

  final UserRepository userRepository;

  Future<dynamic> _onUpdateUser(
    CurrentUserUpdated event,
    Emitter<CurrentUserState> emit,
  ) async {
    final activeChildIndex =
        event.user.children.indexWhere((element) => element.isActive);

    emit(state.copyWith(
      user: event.user,
      activeChild:
          activeChildIndex == -1 ? null : event.user.children[activeChildIndex],
      background: event.user.background,
    ));
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
