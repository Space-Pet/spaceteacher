import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;
  MenuBloc(
      {required this.appFetchApiRepo,
      required this.currentUserBloc,
      required this.userRepository})
      : super(
            MenuState(menu: Menu.empty(), user: userRepository.notSignedIn())) {
    on<GetMenu>(_onGetMenu);
  }
  void _onGetMenu(
    GetMenu event,
    Emitter<MenuState> emit,
  ) async {
    try {
      emit(state.copyWith(menuStatus: MenuStatus.init, date: DateTime.now()));
      final data = await appFetchApiRepo.getMenu(
          userKey: currentUserBloc.state.user.user_key, date: event.txtDate);
      emit(state.copyWith(menuStatus: MenuStatus.success, menu: data, date: event.date));
    } catch (e) {
      emit(state.copyWith(menuStatus: MenuStatus.error));
    }
  }
}