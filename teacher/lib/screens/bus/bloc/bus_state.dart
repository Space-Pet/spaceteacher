// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bus_bloc.dart';

enum BusStatus {
  init,
  loading,
  success,
  failure,
  loadingPost,
  successPost,
  successGetListAttendance
}

class BusState extends Equatable {
  const BusState({
    this.busSchedules = const [],
    required this.selectedDate,
    this.status = BusStatus.init,
    this.detailBusSchedule,
    this.listAttendanceBus,
    required this.userData,
    this.message = '',
    this.type = '',
  });

  final List<BusScheduleTeacher> busSchedules;
  final DetailBusSchedule? detailBusSchedule;
  final DateTime selectedDate;
  final BusStatus status;
  final TeacherDetail userData;
  final Pupils? listAttendanceBus;
  final String message;
  final String type;
  BusState copyWith({
    String? type,
    String? message,
    Pupils? listAttendanceBus,
    TeacherDetail? userData,
    DetailBusSchedule? detailBusSchedule,
    List<BusScheduleTeacher>? busSchedules,
    DateTime? selectedDate,
    BusStatus? status,
  }) {
    return BusState(
      type: type ?? this.type,
      message: message ?? this.message,
      listAttendanceBus: listAttendanceBus ?? this.listAttendanceBus,
      userData: userData ?? this.userData,
      detailBusSchedule: detailBusSchedule ?? this.detailBusSchedule,
      busSchedules: busSchedules ?? this.busSchedules,
      selectedDate: selectedDate ?? this.selectedDate,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        busSchedules,
        selectedDate,
        status,
        detailBusSchedule,
        userData,
        listAttendanceBus,
        message,
      ];
}
