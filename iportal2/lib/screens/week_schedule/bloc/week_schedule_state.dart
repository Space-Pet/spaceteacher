part of 'week_schedule_bloc.dart';

enum WeekScheduleStatus { init, success, error }

class WeekScheduleState extends Equatable {
  const WeekScheduleState({
    required this.weekSchedule,
    this.date,
    this.weekScheduleStatus = WeekScheduleStatus.init,
    required this.user,
  });

  final WeekSchedule weekSchedule;
  final WeekScheduleStatus weekScheduleStatus;
  final ProfileInfo user;
  final DateTime? date;

  @override
  List<Object?> get props => [weekSchedule, weekScheduleStatus];

  WeekScheduleState copyWith({
    DateTime? date,
    WeekSchedule? weekSchedule,
    WeekScheduleStatus? weekScheduleStatus,
    ProfileInfo? user,
  }) {
    return WeekScheduleState(
        date: date ?? this.date,
        user: user ?? this.user,
        weekSchedule: weekSchedule ?? this.weekSchedule,
        weekScheduleStatus: weekScheduleStatus ?? this.weekScheduleStatus);
  }
}
