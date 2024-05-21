part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();
  @override
  List<Object?> get props => [];
}

class GetMenu extends MenuEvent {
  const GetMenu({required this.txtDate, required this.date, required this.user_key});
  final String txtDate;
  final DateTime date;
  final String user_key;
}
