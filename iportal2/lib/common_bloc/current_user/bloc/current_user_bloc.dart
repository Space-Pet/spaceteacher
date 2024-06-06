import 'package:core/core.dart';
import 'package:repository/repository.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  CurrentUserBloc({required this.userRepository})
      : super(
          CurrentUserState(
            activeChild: LocalChildren.empty(),
            user: LocalIPortalProfile.empty(),
          ),
        ) {
    on<CurrentUserUpdated>(_onUpdateUser);
    on<BackGroundUpdatedState>(updateBg);
    on<CurrentUserChangeActiveChild>(_changeActiveChild);
  }

  final UserRepository userRepository;

  Future<dynamic> _onUpdateUser(
    CurrentUserUpdated event,
    Emitter<CurrentUserState> emit,
  ) async {
    final activeChild =
        event.user.children.firstWhere((element) => element.isActive);

    emit(state.copyWith(
      user: event.user,
      activeChild: activeChild,
      background: activeChild.background,
    ));
  }

  void _changeActiveChild(
    CurrentUserChangeActiveChild event,
    Emitter<CurrentUserState> emit,
  ) async {
    final activeChild = event.child;

    final newUser = state.user.copyWith(
      children: state.user.children
          .map((e) => e.copyWith(isActive: e.user_id == activeChild.user_id))
          .toList(),
    );

    userRepository.saveUser(newUser);

    emit(state.copyWith(
      user: newUser,
      activeChild: activeChild,
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
