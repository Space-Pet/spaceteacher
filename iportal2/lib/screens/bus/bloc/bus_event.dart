part of 'bus_bloc.dart';

@immutable
sealed class BusEvent {}

class BusFetchedSchedules extends BusEvent {}

class BusChangedDate extends BusEvent {
  final DateTime date;
  BusChangedDate({
    required this.date,
  });
}
