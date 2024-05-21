// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bus_bloc.dart';

enum BusStatus { init, loading, success, failure }

class BusState extends Equatable {
  const BusState({
    this.busSchedules = const [],
    required this.selectedDate,
    this.status = BusStatus.init,
  });

  final List<BusModel> busSchedules;
  final DateTime selectedDate;
  final BusStatus status;

  BusState copyWith({
    List<BusModel>? busSchedules,
    DateTime? selectedDate,
    BusStatus? status,
  }) {
    return BusState(
      busSchedules: busSchedules ?? this.busSchedules,
      selectedDate: selectedDate ?? this.selectedDate,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [busSchedules, selectedDate, status];
}
