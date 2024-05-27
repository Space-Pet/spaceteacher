part of 'week_schedule_bloc.dart';

enum WeekScheduleStatus { init, success, error }

class WeekScheduleState extends Equatable {
  const WeekScheduleState({
    this.weekSchedule,
    this.date,
    this.weekScheduleStatus = WeekScheduleStatus.init,
  });
  final WeekSchedule? weekSchedule;
  final WeekScheduleStatus weekScheduleStatus;
  final DateTime? date;

  @override
  List<Object?> get props => [weekSchedule, weekScheduleStatus];

  WeekScheduleState copyWith({
    DateTime? date,
    WeekSchedule? weekSchedule,
    WeekScheduleStatus? weekScheduleStatus,
  }) {
    return WeekScheduleState(
        date: date ?? this.date,
        weekSchedule: weekSchedule ?? this.weekSchedule,
        weekScheduleStatus: weekScheduleStatus ?? this.weekScheduleStatus);
  }
}
