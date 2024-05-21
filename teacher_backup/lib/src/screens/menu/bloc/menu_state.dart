part of 'menu_bloc.dart';

enum MenuStatus { init, success, error }

class MenuState extends Equatable {
  const MenuState(
      {required this.menu, this.date, this.menuStatus = MenuStatus.init});
  final MenuInWeekModel menu;
  final MenuStatus menuStatus;
  final DateTime? date;
  @override
  List<Object?> get props => [menu, menuStatus, date];
  MenuState copyWith({
    MenuInWeekModel? menu,
    DateTime? date,
    MenuStatus? menuStatus,
  }) {
    return MenuState(
        date: date ?? this.date,
        menu: menu ?? this.menu,
        menuStatus: menuStatus ?? this.menuStatus);
  }
}
