part of 'menu_bloc.dart';

enum MenuStatus { init, success, error }

class MenuState extends Equatable {
  const MenuState(
      {required this.user,
      required this.menu,
      this.date,
      this.menuStatus = MenuStatus.init});
  final Menu menu;
  final ProfileInfo user;
  final MenuStatus menuStatus;
  final DateTime? date;
  @override
  List<Object?> get props => [menu, menuStatus, user, date];
  MenuState copyWith({
    Menu? menu,
    DateTime? date,
    MenuStatus? menuStatus,
    ProfileInfo? user,
  }) {
    return MenuState(
        date: date ?? this.date,
        user: user ?? this.user,
        menu: menu ?? this.menu,
        menuStatus: menuStatus ?? this.menuStatus);
  }
}
