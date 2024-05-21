part of 'schedule_bloc.dart';

enum ScheduleStatus { init, loading, success, failure }

class ScheduleState extends Equatable {
  const ScheduleState({
    required this.scheduleData,
    required this.datePicked,
    required this.exerciseDataList,
    this.status = ScheduleStatus.init,
  });

  final Schedule scheduleData;
  final DateTime datePicked;
  final List<ExerciseItem> exerciseDataList;
  final ScheduleStatus status;

  @override
  List<Object?> get props => [
        scheduleData,
        datePicked,
        exerciseDataList,
        status,
      ];

  ScheduleState copyWith({
    Schedule? scheduleData,
    DateTime? datePicked,
    List<ExerciseItem>? exerciseDataList,
    ScheduleStatus? status,
  }) {
    return ScheduleState(
      scheduleData: scheduleData ?? this.scheduleData,
      datePicked: datePicked ?? this.datePicked,
      exerciseDataList: exerciseDataList ?? this.exerciseDataList,
      status: status ?? this.status,
    );
  }
}
