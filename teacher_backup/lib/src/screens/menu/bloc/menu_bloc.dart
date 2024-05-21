import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/model/menu_in_week_model.dart';
import 'package:teacher/repository/menu_repository/menu_repositories.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepository menuRepository;
  MenuBloc({required this.menuRepository})
      : super(MenuState(menu: MenuInWeekModel())) {
    on<GetMenu>(_onGetMenu);
  }
  void _onGetMenu(
    GetMenu event,
    Emitter<MenuState> emit,
  ) async {
    try {
      emit(state.copyWith(menuStatus: MenuStatus.init, date: DateTime.now()));
      final data = await menuRepository.getMenuInWeek(
          userKey: event.user_key, date: event.txtDate);
      emit(state.copyWith(
          menuStatus: MenuStatus.success, menu: data, date: event.date));
    } catch (e) {
      emit(state.copyWith(menuStatus: MenuStatus.error));
    }
  }
}
